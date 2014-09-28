<?php

namespace Ihsw\LedgerBundle\Command;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Finder\Finder;

use Ihsw\LedgerBundle\Command\AbstractCommand;
use Ihsw\LedgerBundle\Entity\Line;
use Ihsw\LedgerBundle\Entity\Item;
use Ihsw\LedgerBundle\Entity\Entry;

class TestCommand extends AbstractCommand
{
	public function configure()
	{
		$this->setName("ihsw:test")
			->setDescription("Test");
	}

	public function execute(InputInterface $input, OutputInterface $output)
	{
		// services
		$container = $this->getContainer();
		$doctrine = $container->get("doctrine");

		// repositories
		$entryRepository = $doctrine->getRepository("IhswLedgerBundle:Entry");
		$lineRepository = $doctrine->getRepository("IhswLedgerBundle:Line");
		$itemRepository = $doctrine->getRepository("IhswLedgerBundle:Item");

		/**
		 * extracting
		 */
		// gathering records
		$finder = new Finder();
		$dir = "/mnt/files/documents/adrian/receipts/";
		$finder->in($dir);
		$files = array_map(function($file){
			$handle = fopen($file->getRealPath(), "r");
			$data = [];
			while (true)
			{
				$line = fgetcsv($handle);
				if ($line === false)
				{
					break;
				}
				$data[] = $line;
			}
			fclose($handle);
			return $data;
		}, iterator_to_array($finder));

		// ensuring the filenames have a correct date
		$invalid = array_filter(array_keys($files), function($filepath){
			$filename = current(array_reverse(explode("/", $filepath)));
			$occurredAtRaw = substr($filename, 0, 0-strlen(".csv"));
			try
			{
				$occurredAt = new \DateTime($occurredAtRaw);
			}
			catch (\Exception $e)
			{
				return true;
			}
			
			return $occurredAtRaw !== $occurredAt->format("Y-m-d H.i");
		});
		if (count($invalid) > 0)
		{
			$this->error(sprintf("%s of %s have invalid filenames!", count($invalid), count($files)));
			foreach ($invalid as $filepath)
			{
				$filename = current(array_reverse(explode("/", $filepath)));
				$this->error($filename);
			}
			$this->error(sprintf("%s of %s have invalid filenames!", count($invalid), count($files)));
			return;
		}

		// gathering existing entries and filtering them out of the file list
		$entries = $entryRepository->findAll();
		$existingDatesOccurred = array_map(function($entry){
			return $entry->getOccurredAt()->format("Y-m-d H.i");
		}, $entries);
		$newFiles = [];
		foreach ($files as $filepath => $data)
		{
			$filename = current(array_reverse(explode("/", $filepath)));
			$occurredAtRaw = substr($filename, 0, 0-strlen(".csv"));
			if (in_array($occurredAtRaw, $existingDatesOccurred))
			{
				continue;
			}

			$newFiles[$filepath] = $data;
		}

		// filtering out ones with invalid data
		$newFilesComposite = array_map(function($filepath, $data){
			return [$filepath, $data];
		}, array_keys($newFiles), array_values($newFiles));
		$invalid = array_filter($newFilesComposite, function($pair){
			return count(array_filter($pair[1], function($line){
				return count($line) < 2 || !is_numeric($line[1]);
			})) > 0;
		});
		if (count($invalid) > 0)
		{
			$this->error(sprintf("%s of %s have invalid data!", count($invalid), count($newFiles)));
			foreach ($invalid as $pair)
			{
				$filename = current(array_reverse(explode("/", $pair[0])));
				$this->error($filename);
			}
			$this->error(sprintf("%s of %s have invalid data!", count($invalid), count($newFiles)));
			return;
		}

		// applying an item name transform list
		$transformList = [
			"Onion" => "Onions",
			"Ground beef" => "Ground Beef",
			"Cash 8dbl rl" => "Toilet Paper",
			"Cash 8DBL RL" => "Toilet Paper",
			"Bagel" => "Bagels",
			"Hot dogs" => "Hotdogs",
			"Jalapeno" => "Jalapeno Peppers",
			"Jalapeno Pepper" => "Jalapeno Peppers",
			"Mushroom" => "Mushrooms",
			"Orange Pepper" => "Red Peppers",
			"Plastic Bag" => "Plastic Bags",
			"Plastig Bags" => "Plastic Bags",
			"Handsoap" => "Hand soap"
		];
		$newFiles = array_map(function($file) use($transformList){
			return array_map(function($line) use($transformList){
				$name = $line[0];
				if (!array_key_exists($name, $transformList))
				{
					return $line;
				}
				return [$transformList[$name], $line[1]];
			}, $file);
		}, $newFiles);

		/**
		 * loading
		 */
		$em = $doctrine->getManager();

		/**
		 * loading items
		 */
		// gathering unique items
		$newNames = [];
		foreach ($newFiles as $file)
		{
			foreach ($file as $line)
			{
				$newNames[$line[0]] = $line[0];
			}
		}

		// keying existing items by name
		$items = $itemRepository->findByName($newNames);
		$keys = array_map(function($item){
			return $item->getName();
		}, $items);
		$items = array_combine($keys, $items);

		// filtering existing items out of the new name list
		$newNames = array_filter($newNames, function($name) use($items){
			return !array_key_exists($name, $items);
		});
		
		// transforming names into items, and persisting them
		$newItems = array_map(function($name){
			$item = new Item();
			$item->setName($name);
			return $item;
		}, $newNames);
		$newItems = array_combine($newNames, $newItems);
		$this->comment(sprintf("New items: %s", count($newItems)));
		foreach ($newItems as $item)
		{
			$em->persist($item);
		}
		$em->flush();

		// merging new items into items
		$items = array_merge($newItems, $items);

		/**
		 * loading entries
		 */
		// gathering existing entries
		$entries = $entryRepository->findAll();
		$existingDatesOccurred = array_map(function($entry){
			return $entry->getOccurredAt()->format("Y-m-d h:i:sA");
		}, $entries);

		// going over the files
		$newEntries = 0;
		$newCost = 0;
		foreach ($newFiles as $filepath => $file)
		{
			$filename = current(array_reverse(explode("/", $filepath)));
			$occurredAt = new \DateTime(substr($filename, 0, 0-strlen(".csv")));
			if (in_array($occurredAt->format("Y-m-d h:i:sA"), $existingDatesOccurred))
			{
				continue;
			}

			$entry = new Entry();
			$entry->setOccurredAt($occurredAt);
			foreach ($file as $data)
			{
				if (is_null($data[1]))
				{
					$this->error($filepath);
					return;
				}

				$line = new Line();
				$line->setEntry($entry)
					->setItem($items[$data[0]])
					->setCost($data[1]);
				$em->persist($line);
				$newCost += $data[1];
			}

			$em->persist($entry);
			$newEntries++;
		}
		$em->flush();

		$this->comment(sprintf("New entries: %s", $newEntries));
		$this->comment(sprintf("Cost added: $%s", number_format($newCost, 2)));
	}
}
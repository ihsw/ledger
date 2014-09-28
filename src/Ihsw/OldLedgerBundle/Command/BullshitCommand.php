<?php

namespace Ihsw\LedgerBundle\Command;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Ihsw\LedgerBundle\Command\AbstractCommand;

class BullshitCommand extends AbstractCommand
{
	protected function configure()
	{
		$this->setName('ihsw:bullshit')
			->setDescription('Fix bullshit');
	}

	protected function invoke(InputInterface $input, OutputInterface $output)
	{
		// services
		$container = $this->getContainer();
		$doctrine = $container->get('doctrine');

		// repositories
		$em = $doctrine->getManager();
		$entryRepository = $em->getRepository('IhswLedgerBundle:Entry');
		$itemRepository = $em->getRepository('IhswLedgerBundle:Item');
		$entryItemRepository = $em->getRepository('IhswLedgerBundle:EntryItem');
		$collectionRepository = $em->getRepository('IhswLedgerBundle:Collection');

		// bullshit

		// fetching the lines
		$filepath = "/home/adrian/downloads/access.log";
		$contents = file_get_contents($filepath);
		$lines = explode("\n", $contents);

		// formatting it
		$dataList = array_map(function($line){
			// removing the timezone
			$line = str_replace(" +0000", "", $line);

			// splitting on a space and removing trailing quotes
			$line = array_map(function($line){
				return trim($line, '"');
			}, explode(" ", $line, 11));

			// something happened and error 400 pages weren't getting through
			if (array_key_exists(6, $line))
			{
				if ($line[6] === "400")
				{
					$newLine = [];
					foreach ($line as $i => $value)
					{
						if ($i === 6)
						{
							$newLine[6] = "fucked";
						}
						elseif ($i > 6)
						{
							$newLine[$i+1] = $value;
						}
						elseif ($i < 6)
						{
							$newLine[$i] = $value;
						}
					}
					$line = $newLine;
				}
			}

			return $line;
		}, $lines);
		
		// gathering counts
		$keys = [];
		foreach ($dataList as $data)
		{
			foreach ($data as $i => $value)
			{
				$keys[$i] = [];
			}
		}
		foreach ($dataList as $data)
		{
			foreach ($data as $i => $value)
			{
				$keys[$i][$value] = 0;
			}
		}
		foreach ($dataList as $data)
		{
			foreach ($data as $i => $value)
			{
				$keys[$i][$value]++;
			}
		}

		// sorting them
		foreach ($keys as $i => $counts)
		{
			arsort($keys[$i]);
		}

		// dividing them
		$sourceIps = $keys[0];
		$datesOccurred = $keys[3];
		$httpMethods = $keys[4];
		$destinationPaths = $keys[5];
		$httpVersions = $keys[6];
		$httpStatuses = $keys[7];
		$responseSize = $keys[8];
		$referrers = $keys[9];
		$userAgents = $keys[10];

		// transforming the dates occurred
		$keys = array_map(function($dateOccurred){
			// 25/Jul/2013:00:45:40
			$matches = [];
			preg_match("/\[(\d+)\/(\w+)\/(\d+)\:(\d+)\:(\d+)\:(\d+)\]/", $dateOccurred, $matches);
			list($na, $day, $month, $year, $hour, $minute, $second) = $matches;
			$datetime = new \DateTime(vsprintf("%s-%s-%s %s:%s:%s", array(
				$year, $month, $day,
				$hour, $minute, $second
			)));
			return $datetime->format("F j, Y h:i:sA");
		}, array_keys($datesOccurred));
		$datesOccurred = array_combine($keys, $datesOccurred);
		print_r(array_slice($datesOccurred, 0, 10, true));
	}
}
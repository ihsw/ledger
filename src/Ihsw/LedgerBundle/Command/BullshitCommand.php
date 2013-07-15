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
		$items = $itemRepository->findAll();
		foreach ($items as $item)
		{
			foreach ($item->getEntryItems() as $entryItem)
			{
				$em->remove($entryItem);
			}
			$em->remove($item);
		}

		$entries = $entryRepository->findAll();
		foreach ($entries as $entry)
		{
			$em->remove($entry);
		}
		$em->flush();
	}
}
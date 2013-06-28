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
		$entryRepository = $doctrine->getRepository('IhswLedgerBundle:Entry');

		// bullshit
		$entries = array_map(function($entry){
			return $entry->toArray();
		}, $entryRepository->findAll());
		print_r($entries);
	}
}
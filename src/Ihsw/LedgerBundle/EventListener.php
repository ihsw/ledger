<?php

namespace Ihsw\LedgerBundle;

use Symfony\Component\DependencyInjection\ContainerInterface;

use Symfony\Component\Console\Event\ConsoleCommandEvent;
use Symfony\Component\Console\Event\ConsoleTerminateEvent;

class EventListener
{
	private $container;

	public function __construct(ContainerInterface $container)
	{
		$this->container = $container;
	}

	public function onConsoleCommand(ConsoleCommandEvent $e)
	{
		$command = $e->getCommand();
		if (!is_subclass_of($command, "Ihsw\LedgerBundle\Command\AbstractCommand")) {
			return;
		}

		$command->setOutput($e->getOutput());
		$command->setStartTime(microtime(true));
		$command->setLog(array());

		$command->write(sprintf("Starting %s...", $command->getName()));
	}

	public function onConsoleTerminate(ConsoleTerminateEvent $e)
	{
		$command = $e->getCommand();
		if (!is_subclass_of($command, "Ihsw\LedgerBundle\Command\AbstractCommand")) {
			return;
		}


		$command->info(sprintf("%s success! %s MB", $command->getName(), round($command->getMemoryUsage(), 2)));
	}
}
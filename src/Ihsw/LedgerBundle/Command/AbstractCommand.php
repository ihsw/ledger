<?php

namespace Ihsw\LedgerBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

abstract class AbstractCommand extends ContainerAwareCommand
{
	private $output;
	private $startTime;
	private $hasConcluded;
	protected $suppressIntro;

	// overriding execute
	protected function execute(InputInterface $input, OutputInterface $output)
	{
		// services
		$container = $this->getContainer();

		// misc
		$this->output = $output;
		$this->startTime = microtime(true);
		$this->hasConcluded = false;

		// outputting start message
		if ($this->suppressIntro !== true)
		{
			$this->write(sprintf("Starting %s...", $this->getName()));
		}

		// executing this command
		try
		{
			$this->invoke($input, $output);
		}
		catch (\Exception $e)
		{
			throw $e;
		}

		// optionally outputting a conclude message
		if ($this->hasConcluded === false)
		{
			$this->conclude();
		}
	}

	// utility
	protected function getExecutionTime()
	{
		return round(microtime(true) - $this->startTime, 2);
	}

	/**
	 * write functions
	 */
	// generic write function
	protected function write($message)
	{
		// formatting the message appropriately and dumping it to the output buffer
		$formattedMessage = sprintf("[%s %ss] %s", date("Y-m-d h:i:sA"), $this->getExecutionTime(), $message);
		$this->output->writeln($formattedMessage);
	}

	// derived write functions
	protected function conclude($message = null, $fail = false)
	{
		$this->hasConcluded = true;
		$message = $message ?: sprintf("%s success!", $this->getName());
		$this->info(sprintf("%s %s MB", $message, round(memory_get_peak_usage()/(1024*1024), 2)));
	}

	protected function info($message)
	{
		$this->write(sprintf("<info>%s</info>", $message));
	}

	protected function comment($message)
	{
		$this->write(sprintf("<comment>%s</comment>", $message));
	}

	protected function question($message)
	{
		$this->write(sprintf("<question>%s</question>", $message));
	}

	protected function error($message)
	{
		$this->write(sprintf("<error>%s</error>", $message));
	}

	/**
	 * confirmation functions
	 */
	protected function confirm($message, $default = true)
	{
		$dialog = $this->getHelperSet()->get("dialog");
		return $dialog->askConfirmation($this->output, sprintf("<question>%s</question> ", $message), $default);
	}

	protected function ask($message, $default = null)
	{
		$dialog = $this->getHelperSet()->get("dialog");
		return $dialog->ask($this->output, sprintf("<question>%s</question> ", $message), $default);
	}
}
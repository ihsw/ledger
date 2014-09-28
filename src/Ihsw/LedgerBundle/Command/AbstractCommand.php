<?php

namespace Ihsw\LedgerBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

abstract class AbstractCommand extends ContainerAwareCommand
{
	private $output;
	private $startTime;
	private $log;

	/**
	 * accessors
	 */
	public function setOutput(OutputInterface $output) { $this->output = $output; }
	public function setStartTime($startTime) { $this->startTime = $startTime; }
	public function setLog($log) { $this->log = $log; }

	/**
	 * utility
	 */
	protected function getExecutionTime()
	{
		return microtime(true) - $this->startTime;
	}

	public function getMemoryUsage()
	{
		return memory_get_peak_usage()/(1024*1024);
	}

	protected function get($service)
	{
		return $this->getContainer()->get($service);
	}

	/**
	 * write functions
	 */
	// generic write function
	public function write($message)
	{
		// formatting the message appropriately, dumping it to the output buffer, and logging it in a list
		$formattedMessage = sprintf("[%s %ss] %s", date("Y-m-d h:i:sA"), round($this->getExecutionTime(), 2), $message);
		$this->output->writeln($formattedMessage);
		$this->log[] = $formattedMessage;
	}

	/**
	 * derived write functions
	 */
	public function info($message)
	{
		$this->write(sprintf("<info>%s</info>", $message));
	}

	public function comment($message)
	{
		$this->write(sprintf("<comment>%s</comment>", $message));
	}

	public function question($message)
	{
		$this->write(sprintf("<question>%s</question>", $message));
	}

	public function error($message)
	{
		$this->write(sprintf("<error>%s</error>", $message));
	}

	/**
	 * confirmation functions
	 */
	public function confirm($message, $default = true)
	{
		$dialog = $this->getHelperSet()->get("dialog");
		return $dialog->askConfirmation($this->output, sprintf("<question>%s</question> ", $message), $default);
	}

	public function ask($message, $default = null)
	{
		$dialog = $this->getHelperSet()->get("dialog");
		return $dialog->ask($this->output, sprintf("<question>%s</question> ", $message), $default);
	}
}
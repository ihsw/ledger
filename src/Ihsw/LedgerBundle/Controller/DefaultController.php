<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
	public function indexAction()
	{
		// services
		$doctrine = $this->get("doctrine");

		// repositories
		$entryRepository = $doctrine->getRepository("IhswLedgerBundle:Entry");

		// misc
		$entries = $entryRepository->findAll();

		/**
		 * aggregate data
		 */
		// calculating it all
		$getTimestamp = [
			"weekly" => function(\DateTime $occurredAt){
				$week = clone $occurredAt;
				$week->modify(sprintf("-%s days", $occurredAt->format("N")));
				return strtotime($week->format("Y-m-d"));
			},
			"monthly" => function(\DateTime $occurredAt){
				$month = new \DateTime($occurredAt->format("Y-m"));
				return $month->getTimestamp();
			}
		];
		$aggregateData = array_combine(array_keys($getTimestamp), array_fill(0, count($getTimestamp), []));
		foreach ($entries as $entry)
		{
			$entryCost = array_reduce($entry->getLines()->toArray(), function($total, $line){
				return $total + $line->getCost();
			}, 0);

			foreach ($getTimestamp as $key => $transform)
			{
				$timestamp = $transform($entry->getOccurredAt());
				if (!array_key_exists($timestamp, $aggregateData[$key]))
				{
					$aggregateData[$key][$timestamp] = 0;
				}
				$aggregateData[$key][$timestamp] += $entryCost;
			}
		}

		// transforming it to be highcharts-friendly
		$dataStrings = [];
		foreach ($aggregateData as $key => $data)
		{
			$dataValue = [];
			foreach ($data as $timestamp => $value)
			{
				$month = new \DateTime(sprintf("@%s", $timestamp));
				$occurredAtValue = sprintf("Date.UTC(%s,%s,%s)",
					$month->format("Y"),
					$month->format("m")-1,
					$month->format("d")
				);

				$dataValue[] = sprintf("[%s,%s]", $occurredAtValue, $value);
			}
			$dataStrings[$key] = sprintf("[%s]", implode(",", $dataValue));
		}

		/**
		 * pie charts
		 */
		// gathering up the data
		$items = [];
		$itemCosts = [];
		$itemQuantities = [];
		foreach ($entries as $entry)
		{
			foreach ($entry->getLines() as $line)
			{
				$itemId = $line->getItem()->getId();
				if (!array_key_exists($itemId, $itemCosts))
				{
					$itemCosts[$itemId] = 0;
				}
				if (!array_key_exists($itemId, $itemQuantities))
				{
					$itemQuantities[$itemId] = 0;
				}

				$itemCosts[$itemId] += $line->getCost();
				$itemQuantities[$itemId]++;
				$items[$itemId] = $line->getItem();
			}
		}
		arsort($itemCosts);
		arsort($itemQuantities);

		// flattening bottom N-th percent
		$totalCost = array_sum($itemCosts);
		$itemCostData = [];
		$otherCost = 0;
		foreach (array_reverse($itemCosts, true) as $itemId => $cost)
		{
			$itemName = $items[$itemId]->getName();

			$nextOtherCost = $otherCost + $cost;
			if (($nextOtherCost / $totalCost) > 0.25)
			{
				$itemCostData[] = [$itemName, $cost];
				continue;
			}
			$otherCost += $cost;
		}
		$itemCostData = array_reverse($itemCostData);
		$itemCostData[] = ["Other", $otherCost];

		$totalQuantity = array_sum($itemQuantities);
		$itemQuantityData = [];
		$otherQuantity = 0;
		foreach (array_reverse($itemQuantities, true) as $itemId => $quantity)
		{
			$itemName = $items[$itemId]->getName();

			$nextOtherQuantity = $otherQuantity + $quantity;
			if (($nextOtherQuantity / $totalQuantity) > 0.25)
			{
				$itemQuantityData[] = [$itemName, $quantity];
				continue;
			}
			$otherQuantity += $quantity;
		}
		$itemQuantityData = array_reverse($itemQuantityData);
		$itemQuantityData[] = ["Other", $otherQuantity];

		/**
		 * column charts
		 */
		// finding days where most is spent
		$daysOfWeek = array_map(function($dayOfWeek){
			$sunday = new \DateTime("last sunday");
			$sunday->modify(sprintf("+%s days", $dayOfWeek));
			return $sunday->format("D");
		}, range(0, 6));
		$dayCosts = array_combine(array_keys($daysOfWeek), array_fill(0, count($daysOfWeek), 0));
		foreach ($entries as $entry)
		{
			$entryCost = array_reduce($entry->getLines()->toArray(), function($total, $line){
				return $total + $line->getCost();
			}, 0);

			$dayOfWeek = $entry->getOccurredAt()->format("N")-1;
			$dayCosts[$dayOfWeek] += $entryCost;
		}
		$dayCostData = array_map(function($dayOfWeek, $dayName) use($dayCosts){
			return [$dayName, $dayCosts[$dayOfWeek]];
		}, array_keys($daysOfWeek), array_values($daysOfWeek));

		// finding hours where most is spent
		$hours = array_map(function($hour){
			$day = new \DateTime(date("Y-m-d"));
			$day->modify(sprintf("+%s hour", $hour));
			return $day->format("ga");
		}, range(0, 23));
		$hourCosts = array_combine(array_keys($hours), array_fill(0, count($hours), 0));
		foreach ($entries as $entry)
		{
			$entryCost = array_reduce($entry->getLines()->toArray(), function($total, $line){
				return $total + $line->getCost();
			}, 0);

			$hour = $entry->getOccurredAt()->format("G");
			$hourCosts[$hour] += $entryCost;
		}
		$hourCostData = array_map(function($hour, $hourName) use($hourCosts){
			return [$hourName, $hourCosts[$hour]];
		}, array_keys($hours), array_values($hours));

		return $this->render("IhswLedgerBundle:Default:index.html.twig", [
			"dataStrings" => $dataStrings,
			"itemCostData" => $itemCostData,
			"totalCost" => $totalCost,
			"itemQuantityData" => $itemQuantityData,
			"dayCostData" => $dayCostData,
			"hourCostData" => $hourCostData
		]);
	}
}

<?php

namespace Ihsw\LedgerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * EntryItem
 */
class EntryItem implements \JsonSerializable
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var float
     */
    private $cost;


    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set cost
     *
     * @param float $cost
     * @return EntryItem
     */
    public function setCost($cost)
    {
        $this->cost = $cost;
    
        return $this;
    }

    /**
     * Get cost
     *
     * @return float 
     */
    public function getCost()
    {
        return $this->cost;
    }
    /**
     * @var \Ihsw\LedgerBundle\Entity\Item
     */
    private $Item;


    /**
     * Set Item
     *
     * @param \Ihsw\LedgerBundle\Entity\Item $item
     * @return EntryItem
     */
    public function setItem(\Ihsw\LedgerBundle\Entity\Item $item = null)
    {
        $this->Item = $item;
    
        return $this;
    }

    /**
     * Get Item
     *
     * @return \Ihsw\LedgerBundle\Entity\Item 
     */
    public function getItem()
    {
        return $this->Item;
    }
    /**
     * @var \Ihsw\LedgerBundle\Entity\Entry
     */
    private $entry;

    /**
     * @var \Ihsw\LedgerBundle\Entity\Item
     */
    private $item;


    /**
     * Set entry
     *
     * @param \Ihsw\LedgerBundle\Entity\Entry $entry
     * @return EntryItem
     */
    public function setEntry(\Ihsw\LedgerBundle\Entity\Entry $entry = null)
    {
        $this->entry = $entry;
    
        return $this;
    }

    /**
     * Get entry
     *
     * @return \Ihsw\LedgerBundle\Entity\Entry 
     */
    public function getEntry()
    {
        return $this->entry;
    }

    public function jsonSerialize()
    {
        return [
            "id" => $this->getId(),
            "entry" => $this->getEntry()->jsonSerialize(),
            "item" => $this->getItem()->jsonSerialize()
        ];
    }
}
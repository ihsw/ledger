<?php

namespace Ihsw\LedgerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Line
 */
class Line
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
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
     * @param string $cost
     * @return Line
     */
    public function setCost($cost)
    {
        $this->cost = $cost;

        return $this;
    }

    /**
     * Get cost
     *
     * @return string 
     */
    public function getCost()
    {
        return $this->cost;
    }
    /**
     * @var \Ihsw\LedgerBundle\Entity\Entry
     */
    private $entry;


    /**
     * Set entry
     *
     * @param \Ihsw\LedgerBundle\Entity\Entry $entry
     * @return Line
     */
    public function setEntry(\Ihsw\LedgerBundle\Entity\Entry $entry)
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
    /**
     * @var \Ihsw\LedgerBundle\Entity\Item
     */
    private $item;


    /**
     * Set item
     *
     * @param \Ihsw\LedgerBundle\Entity\Item $item
     * @return Line
     */
    public function setItem(\Ihsw\LedgerBundle\Entity\Item $item)
    {
        $this->item = $item;

        return $this;
    }

    /**
     * Get item
     *
     * @return \Ihsw\LedgerBundle\Entity\Item 
     */
    public function getItem()
    {
        return $this->item;
    }
}

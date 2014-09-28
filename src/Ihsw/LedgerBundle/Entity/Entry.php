<?php

namespace Ihsw\LedgerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Entry
 */
class Entry
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
     * @return Entry
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
     * @var \DateTime
     */
    private $occurredAt;


    /**
     * Set occurredAt
     *
     * @param \DateTime $occurredAt
     * @return Entry
     */
    public function setOccurredAt($occurredAt)
    {
        $this->occurredAt = $occurredAt;

        return $this;
    }

    /**
     * Get occurredAt
     *
     * @return \DateTime 
     */
    public function getOccurredAt()
    {
        return $this->occurredAt;
    }
    /**
     * @var \Doctrine\Common\Collections\Collection
     */
    private $lines;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->lines = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Add lines
     *
     * @param \Ihsw\LedgerBundle\Entity\Line $lines
     * @return Entry
     */
    public function addLine(\Ihsw\LedgerBundle\Entity\Line $lines)
    {
        $this->lines[] = $lines;

        return $this;
    }

    /**
     * Remove lines
     *
     * @param \Ihsw\LedgerBundle\Entity\Line $lines
     */
    public function removeLine(\Ihsw\LedgerBundle\Entity\Line $lines)
    {
        $this->lines->removeElement($lines);
    }

    /**
     * Get lines
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getLines()
    {
        return $this->lines;
    }
}

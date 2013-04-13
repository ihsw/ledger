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
     * @var \DateTime
     */
    private $occurredAt;


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
    private $entryitems;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->entryitems = new \Doctrine\Common\Collections\ArrayCollection();
    }
    
    /**
     * Add entryitems
     *
     * @param \Ihsw\LedgerBundle\Entity\EntryItem $entryitems
     * @return Entry
     */
    public function addEntryitem(\Ihsw\LedgerBundle\Entity\EntryItem $entryitems)
    {
        $this->entryitems[] = $entryitems;
    
        return $this;
    }

    /**
     * Remove entryitems
     *
     * @param \Ihsw\LedgerBundle\Entity\EntryItem $entryitems
     */
    public function removeEntryitem(\Ihsw\LedgerBundle\Entity\EntryItem $entryitems)
    {
        $this->entryitems->removeElement($entryitems);
    }

    /**
     * Get entryitems
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getEntryitems()
    {
        return $this->entryitems;
    }
}
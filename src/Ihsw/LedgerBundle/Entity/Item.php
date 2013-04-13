<?php

namespace Ihsw\LedgerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Item
 */
class Item
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
     */
    private $name;


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
     * Set name
     *
     * @param string $name
     * @return Item
     */
    public function setName($name)
    {
        $this->name = $name;
    
        return $this;
    }

    /**
     * Get name
     *
     * @return string 
     */
    public function getName()
    {
        return $this->name;
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
     * @return Item
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
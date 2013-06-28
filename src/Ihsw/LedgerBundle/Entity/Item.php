<?php

namespace Ihsw\LedgerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Item
 */
class Item implements \JsonSerializable
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

    public function jsonSerialize()
    {
        return [
            "id" => $this->getId(),
            "name" => $this->getName()
        ];
    }
    /**
     * @var \Doctrine\Common\Collections\Collection
     */
    private $entryItems;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->entryItems = new \Doctrine\Common\Collections\ArrayCollection();
    }
    
    /**
     * Add entryItems
     *
     * @param \Ihsw\LedgerBundle\Entity\EntryItem $entryItems
     * @return Item
     */
    public function addEntryItem(\Ihsw\LedgerBundle\Entity\EntryItem $entryItems)
    {
        $this->entryItems[] = $entryItems;
    
        return $this;
    }

    /**
     * Remove entryItems
     *
     * @param \Ihsw\LedgerBundle\Entity\EntryItem $entryItems
     */
    public function removeEntryItem(\Ihsw\LedgerBundle\Entity\EntryItem $entryItems)
    {
        $this->entryItems->removeElement($entryItems);
    }

    /**
     * Get entryItems
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getEntryItems()
    {
        return $this->entryItems;
    }
}
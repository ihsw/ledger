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

    public function jsonSerializeWithCollection()
    {
        return [
            "id" => $this->getId(),
            "name" => $this->getName(),
            "collection" => $this->getCollection()
        ];
    }

    public function jsonSerializeWithEntryItems()
    {
        return [
            "id" => $this->getId(),
            "name" => $this->getName(),
            "entry_items" => $this->getEntryItems()
        ];
    }

    public function jsonSerializeWithEntryItemsAndCollection()
    {
        return [
            "id" => $this->getId(),
            "name" => $this->getName(),
            "entry_items" => $this->getEntryItems(),
            "collection" => $this->getCollection()
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
    /**
     * @var \Ihsw\LedgerBundle\Entity\Collection
     */
    private $collection;


    /**
     * Set collection
     *
     * @param \Ihsw\LedgerBundle\Entity\Collection $collection
     * @return Item
     */
    public function setCollection(\Ihsw\LedgerBundle\Entity\Collection $collection = null)
    {
        $this->collection = $collection;

        return $this;
    }

    /**
     * Get collection
     *
     * @return \Ihsw\LedgerBundle\Entity\Collection 
     */
    public function getCollection()
    {
        return $this->collection;
    }
}

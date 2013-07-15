<?php

namespace Ihsw\LedgerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Collection
 */
class Collection implements \JsonSerializable
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
     * @return Collection
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
    private $items;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->items = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Add items
     *
     * @param \Ihsw\LedgerBundle\Entity\Item $items
     * @return Collection
     */
    public function addItem(\Ihsw\LedgerBundle\Entity\Item $items)
    {
        $this->items[] = $items;

        return $this;
    }

    /**
     * Remove items
     *
     * @param \Ihsw\LedgerBundle\Entity\Item $items
     */
    public function removeItem(\Ihsw\LedgerBundle\Entity\Item $items)
    {
        $this->items->removeElement($items);
    }

    /**
     * Get items
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getItems()
    {
        return $this->items;
    }

    public function jsonSerialize()
    {
        return [
            "id" => $this->getId(),
            "name" => $this->getName()
        ];
    }

    public function jsonSerializeWithItems()
    {
        $items = array_map(function($item){
            return $item->jsonSerializeWithEntryItemsAndCollection();
        }, $this->getItems()->toArray());
        return [
            "id" => $this->getId(),
            "name" => $this->getName(),
            'items' => $items
        ];
    }
}

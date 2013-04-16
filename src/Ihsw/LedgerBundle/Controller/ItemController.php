<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Ihsw\LedgerBundle\Entity\Item;

class ItemController extends Controller
{
    public function indexAction()
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $itemRepository = $em->getRepository('IhswLedgerBundle:Item');

        // fetching items
        $items = $itemRepository->findAll();

        return new JsonResponse($items);
    }

    public function createAction()
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $itemRepository = $em->getRepository('IhswLedgerBundle:Item');

        // inserting the item
        $content = json_decode($request->getContent(), true);
        $name = $content['name'];
        $item = new Item();
        $item->setName($name);
        $em->persist($item);
        $em->flush();

        return new JsonResponse($item);
    }
}
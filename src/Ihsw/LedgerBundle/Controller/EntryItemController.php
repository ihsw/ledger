<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Ihsw\LedgerBundle\Entity\EntryItem;

class EntryItemController extends Controller
{
    /**
     * @ParamConverter("entry")
     */
    public function createAction($entry)
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $itemRepository = $em->getRepository('IhswLedgerBundle:Item');

        // gathering the content
        $content = json_decode($request->getContent(), true);
        if (is_null($content) === true)
        {
            return new Response(null, 400);
        }

        // validating the item-id
        $item = $itemRepository->findOneById($content["item"]["id"]);
        if (is_null($item) === true)
        {
            return new Response(null, 400);
        }

        // creating an entry entity and persisting it
        $entryItem = new EntryItem();
        $entryItem->setItem($item)
            ->setEntry($entry)
            ->setCost($content["cost"])
            ->setQuantity($content["quantity"]);
        $em->persist($entryItem);
        $em->flush();

        return new JsonResponse();
    }

    /**
     * @ParamConverter("entryItem")
     */
    public function destroyAction($entryItem)
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryItemRepository = $em->getRepository('IhswLedgerBundle:EntryItem');

        // deleting the entry-item
        $em->remove($entryItem);
        $em->flush();

        return new Response();
    }

    /**
     * @ParamConverter("entryItem")
     */
    public function showAction($entryItem)
    {
        return new JsonResponse($entryItem);
    }

    /**
     * @ParamConverter("entryItem")
     */
    public function updateAction($entryItem)
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $itemRepository = $em->getRepository('IhswLedgerBundle:Item');

        // gathering the content
        $content = json_decode($request->getContent(), true);
        if (is_null($content) === true)
        {
            return new Response(null, 400);
        }

        // validating the item-id
        $item = $itemRepository->findOneById($content["item"]["id"]);
        if (is_null($item) === true)
        {
            return new Response(null, 400);
        }

        // updating the item
        $entryItem->setItem($item)
            ->setCost($content["cost"])
            ->setQuantity($content["quantity"]);
        $em->persist($entryItem);
        $em->flush();

        return new JsonResponse($entryItem);
    }
}
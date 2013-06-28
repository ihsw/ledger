<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Ihsw\LedgerBundle\Entity\Entry;
use Ihsw\LedgerBundle\Entity\EntryItem;

class EntryController extends Controller
{
    public function indexAction()
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryRepository = $em->getRepository('IhswLedgerBundle:Entry');

        // fetching entries
        $entries = $entryRepository->findAll();

        return new JsonResponse($entries);
    }

    public function createAction()
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryRepository = $em->getRepository('IhswLedgerBundle:Entry');

        // inserting the entry
        $content = json_decode($request->getContent(), true);
        $entry = new Entry();
        $entry->setOccurredAt(new \DateTime($content['occurredAt']));
        $em->persist($entry);
        $em->flush();

        return new JsonResponse($entry);
    }

    /**
     * @ParamConverter("entry")
     */
    public function destroyAction($entry)
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryRepository = $em->getRepository('IhswLedgerBundle:Entry');

        // deleting the entry
        $em->remove($entry);
        $em->flush();

        return new Response();
    }

    /**
     * @ParamConverter("entry")
     */
    public function showAction($entry)
    {
        return new JsonResponse($entry);
    }

    /**
     * @ParamConverter("entry")
     */
    public function addEntryItemAction($entry)
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
            ->setCost($content["cost"]);
        $em->persist($entryItem);
        $em->flush();

        return new JsonResponse();
    }
}
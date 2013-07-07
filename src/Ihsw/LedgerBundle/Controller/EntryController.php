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
        $entryItemRepository = $em->getRepository('IhswLedgerBundle:EntryItem');

        // fetching entries
        $entries = array_map(function($entry) use($entryItemRepository){
            return $entry->jsonSerializeWithEntryItems();
        }, $entryRepository->findAll());

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
        foreach ($entry->getEntryItems() as $entryItem)
        {
            $em->remove($entryItem);
        }
        $em->remove($entry);
        $em->flush();

        return new Response();
    }

    /**
     * @ParamConverter("entry")
     */
    public function showAction($entry)
    {
        return new JsonResponse($entry->jsonSerializeWithEntryItems());
    }

    /**
     * @ParamConverter("entry")
     */
    public function updateAction($entry)
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();

        // updating the entry
        $content = json_decode($request->getContent(), true);
        $entry->setOccurredAt(new \DateTime($content['occurred_at']));
        $em->persist($entry);
        $em->flush();

        return new JsonResponse($entry);
    }
}
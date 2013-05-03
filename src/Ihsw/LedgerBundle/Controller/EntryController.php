<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Ihsw\LedgerBundle\Entity\Entry;

class EntryController extends Controller
{
    public function indexAction()
    {
        sleep(1);

        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryRepository = $em->getRepository('IhswLedgerBundle:Entry');

        // fetching items
        $entries = $entryRepository->findAll();
        $keys = array_map(function($entry){
            return $entry->getId();
        }, $entries);
        $entries = array_combine($keys, $entries);

        return new JsonResponse($entries);
    }

    public function createAction()
    {
        sleep(1);

        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $itemRepository = $em->getRepository('IhswLedgerBundle:Item');

        // inserting the item
        $content = json_decode($request->getContent(), true);
        $item = new Item();
        $item->setName($content['name']);
        $em->persist($item);
        $em->flush();

        return new JsonResponse($item);
    }

    /**
     * @ParamConverter("item")
     */
    public function destroyAction($item)
    {
        sleep(1);

        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $itemRepository = $em->getRepository('IhswLedgerBundle:Item');

        // deleting the item
        $em->remove($item);
        $em->flush();

        return new Response();
    }
}
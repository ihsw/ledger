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
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryRepository = $em->getRepository('IhswLedgerBundle:Entry');

        // fetching entries
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
        sleep(1);

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
}
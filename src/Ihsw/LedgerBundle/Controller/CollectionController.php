<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Ihsw\LedgerBundle\Entity\Collection;

class CollectionController extends Controller
{
    public function indexAction()
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $collectionRepository = $em->getRepository('IhswLedgerBundle:Collection');

        // fetching collections
        $collections = array_map(function($collection){
            return $collection->jsonSerializeWithItems();
        }, $collectionRepository->findAll());

        return new JsonResponse($collections);
    }

    public function createAction()
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $collectionRepository = $em->getRepository('IhswLedgerBundle:Collection');

        // inserting the collection
        $content = json_decode($request->getContent(), true);
        $collection = new Collection();
        $collection->setName($content['name']);
        $em->persist($collection);
        $em->flush();

        return new JsonResponse($collection);
    }

    /**
     * @ParamConverter("collection")
     */
    public function destroyAction($collection)
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $collectionRepository = $em->getRepository('IhswLedgerBundle:Collection');

        // deleting the collection
        $em->remove($collection);
        $em->flush();

        return new Response();
    }

    /**
     * @ParamConverter("collection")
     */
    public function showAction($collection)
    {
        return new JsonResponse($collection->jsonSerializeWithItems());
    }

    /**
     * @ParamConverter("collection")
     */
    public function updateAction($collection)
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $collectionRepository = $em->getRepository('IhswLedgerBundle:Collection');

        // updating the collection
        $content = json_decode($request->getContent(), true);
        $collection->setName($content['name']);
        $em->persist($collection);
        $em->flush();

        return new JsonResponse($collection);
    }
}
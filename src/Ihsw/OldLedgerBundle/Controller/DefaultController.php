<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('IhswLedgerBundle::base.html.twig');
    }

    public function summaryAction()
    {
        // services
        $request = $this->get('request');
        $doctrine = $this->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryRepository = $em->getRepository('IhswLedgerBundle:Entry');

        // gathering summaries
        $data = [
            "entry_count" => $entryRepository->getCount()
        ];

        return new JsonResponse($data);
    }
}
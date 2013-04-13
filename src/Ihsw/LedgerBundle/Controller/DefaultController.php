<?php

namespace Ihsw\LedgerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('IhswLedgerBundle:Default:index.html.twig', array('name' => $name));
    }
}

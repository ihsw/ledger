<?php

namespace Ihsw\LedgerBundle;

use Sensio\Bundle\FrameworkExtraBundle\Request\ParamConverter\ParamConverterInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ConfigurationInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class ParamConverter implements ParamConverterInterface
{
    private $container;
    private $resolverMap;

    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
        $this->resolverMap = [
            'item' => 'resolveItem',
            'entry' => 'resolveEntry'
        ];
    }

    public function apply(Request $request, ConfigurationInterface $configuration)
    {
        $entities = explode('/', $configuration->getName());
        foreach ($this->resolverMap as $entity => $resolver)
        {
            if (in_array($entity, $entities))
            {
                $this->$resolver($request);
            }
        }
    }

    public function supports(ConfigurationInterface $configuration)
    {
        $entities = explode('/', $configuration->getName());
        foreach ($entities as $entity)
        {
            if (!array_key_exists($entity, $this->resolverMap))
            {
                return false;
            }
        }

        return true;
    }

    private function resolveItem(Request $request)
    {
        // services
        $doctrine = $this->container->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $itemRepository = $em->getRepository('IhswLedgerBundle:Item');

        $itemId = $request->attributes->get('itemId');
        $item = $itemRepository->findOneById($itemId);
        if (is_null($item))
        {
            throw new NotFoundHttpException(sprintf('No item found for %s', $itemId));
        }
        $request->attributes->set('item', $item);
    }

    private function resolveEntry(Request $request)
    {
        // services
        $doctrine = $this->container->get('doctrine');

        // repositories
        $em = $doctrine->getManager();
        $entryRepository = $em->getRepository('IhswLedgerBundle:Entry');

        $entryId = $request->attributes->get('entryId');
        $entry = $entryRepository->findOneById($entryId);
        if (is_null($entry))
        {
            throw new NotFoundHttpException(sprintf('No entry found for %s', $entryId));
        }
        $request->attributes->set('entry', $entry);
    }
}
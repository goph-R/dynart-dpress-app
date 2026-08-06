<?php

namespace Dynart\ReadingTime;

use Dynart\Micro\Attribute\Route;
use Dynart\Micro\ConfigInterface;
use Dynart\Micro\JwtAuthInterface;
use Dynart\Micro\RequestInterface;
use Dynart\Micro\RouterInterface;
use Dynart\Micro\ViewInterface;
use Dynart\Dpress\Controller\AbstractController;
use Dynart\Dpress\Service\ContentService;

/**
 * A route a plugin added, to prove one can
 *
 * Nothing registers the *route*: naming the class in `controllers()` puts it in the container,
 * and the attribute processor reflects over everything in there. Constructor injection works the
 * same way it does for the CMS's own controllers - the container resolves the dependencies,
 * including this plugin's own service.
 *
 * Returning an array is what makes the framework answer with JSON.
 */
class ReadingTimeController extends AbstractController {

    public function __construct(
        ViewInterface $view,
        RouterInterface $router,
        RequestInterface $request,
        ConfigInterface $config,
        JwtAuthInterface $jwtAuth,
        protected ContentService $content,
        protected ReadingTimeService $readingTime,
    ) {
        parent::__construct($view, $router, $request, $config, $jwtAuth);
    }

    #[Route('GET', '/reading-time/?')]
    public function minutes(string $id): array {
        $content = $this->content->findById((int)$id);
        if ($content === null) {
            return ['error' => 'no such content'];
        }
        return [
            'id' => $content->id,
            'minutes' => $this->readingTime->minutes($content->id, $content->markdown),
        ];
    }
}

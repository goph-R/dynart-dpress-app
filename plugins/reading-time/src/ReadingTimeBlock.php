<?php

namespace Dynart\ReadingTime;

use Dynart\Micro\ViewInterface;
use Dynart\Dpress\Entity\Block;

/**
 * A block type contributed by a plugin, which is the point of it
 *
 * Small on purpose: what it draws matters less than the fact that a **type** arrived from a folder
 * under `plugins/` and never touched `DpressServices::BLOCKS`. A block is a registration and never
 * a migration, so this brings no table with it - the plugin's other half does that.
 *
 * The class it renders with, `reading-time`, is also the needle in `pageAssets()`, so the
 * stylesheet is on the pages showing one of these and on no others.
 */
class ReadingTimeBlock {

    const DEFAULT_MINUTES = 5;

    public function __construct(protected ViewInterface $view) {}

    public function render(Block $block, array $settings): string {
        $minutes = (int)($settings['minutes'] ?? 0);
        return $this->view->fetch('reading_time:block/badge', [
            'minutes' => $minutes > 0 ? $minutes : self::DEFAULT_MINUTES,
            'title'   => trim((string)($settings['title'] ?? '')),
        ]);
    }
}

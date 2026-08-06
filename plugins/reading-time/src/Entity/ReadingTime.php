<?php

namespace Dynart\ReadingTime\Entity;

use Dynart\Micro\Entities\Attribute\Column;
use Dynart\Micro\Entities\Attribute\Table;
use Dynart\Micro\Entities\Entity;

/**
 * An editor's override of the calculated reading time
 *
 * A table of its own rather than a column on `content`: a plugin that adds columns to the CMS's
 * tables is a plugin you cannot uninstall.
 */
#[Table(name: 'reading_time')]
class ReadingTime extends Entity {

    protected static string $eventName = 'reading_time';

    #[Column(type: Column::TYPE_INT, primaryKey: true, notNull: true)]
    public int $content_id = 0;

    #[Column(type: Column::TYPE_INT, notNull: true, default: 0)]
    public int $minutes = 0;
}

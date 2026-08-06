<?php

namespace Dynart\ReadingTime\Migration;

use Dynart\Micro\Entities\MigrationInterface;
use Dynart\Micro\Entities\QueryExecutor;
use Dynart\ReadingTime\Entity\ReadingTime;

/**
 * The version sorts after every core migration, which is all the interleaving needs
 */
class CreateReadingTimeTable implements MigrationInterface {

    public function __construct(private QueryExecutor $queryExecutor) {}

    public function version(): string {
        return '2026_08_06_001_create_reading_time_table';
    }

    public function up(): void {
        $this->queryExecutor->createTable(ReadingTime::class, true);
    }
}

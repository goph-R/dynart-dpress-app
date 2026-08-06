<?php

namespace Dynart\ReadingTime;

use Dynart\Micro\Entities\EntityManager;
use Dynart\ReadingTime\Entity\ReadingTime;

/**
 * How long a post takes to read
 */
class ReadingTimeService {

    /** Words a minute, which is the usual figure for silent reading of prose */
    const WORDS_PER_MINUTE = 200;

    public function __construct(private EntityManager $em) {}

    public function storedMinutes(int $contentId): ?int {
        $row = $this->em->findById(ReadingTime::class, $contentId);
        return $row instanceof ReadingTime ? $row->minutes : null;
    }

    public function calculate(string $markdown): int {
        $words = str_word_count(strip_tags($markdown));
        return max(1, (int)ceil($words / self::WORDS_PER_MINUTE));
    }

    public function minutes(int $contentId, string $markdown): int {
        return $this->storedMinutes($contentId) ?: $this->calculate($markdown);
    }
}

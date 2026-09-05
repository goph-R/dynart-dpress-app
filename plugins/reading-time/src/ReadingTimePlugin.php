<?php

namespace Dynart\ReadingTime;

use Dynart\Micro\Micro;
use Dynart\Dpress\Form\DpressForm;
use Dynart\Dpress\Form\FormFactory;
use Dynart\Dpress\Form\AdminForms;
use Dynart\Dpress\Plugin\AbstractPlugin;
use Dynart\Dpress\Security\Permissions;

/**
 * An example plugin that uses every extension point at once
 *
 * It is here to be read and to be tested against, rather than because anybody needs it: if this
 * works, the plugin system works. Each piece below is the smallest thing that exercises one
 * capability.
 */
class ReadingTimePlugin extends AbstractPlugin {

    const PERMISSION = 'reading_time.override';

    /**
     * Its own service, so the container can inject it into its own controller
     *
     * Declared here rather than added in `register()`: services go in before controllers, and a
     * controller whose dependency is registered afterwards only fails when somebody visits it.
     */
    public function services(): array {
        return [
            ReadingTimeService::class => ReadingTimeService::class,
            // the block's renderer is a Micro callable, so the container has to know it
            ReadingTimeBlock::class => ReadingTimeBlock::class,
        ];
    }

    /** A field type of its own, rendered by this plugin's own template */
    public function widgets(): array {
        return ['reading_time' => 'reading_time:widget/minutes'];
    }

    public function views(): array {
        return ['reading_time' => dirname(__DIR__).'/views'];
    }

    /**
     * A block type, from a folder under `plugins/`
     *
     * The same definition `DpressServices::BLOCKS` holds for the core three, which is the
     * point: a plugin uses the mechanism the CMS itself eats.
     */
    public function blocks(): array {
        return [
            'reading_time' => [
                'title'  => 'Reading time',
                'render' => [ReadingTimeBlock::class, 'render'],
                'fields' => [
                    'minutes' => ['type' => 'text', 'label' => 'Minutes', 'required' => false,
                                  'description' => 'Empty is '.ReadingTimeBlock::DEFAULT_MINUTES.'.'],
                    'title'   => ['type' => 'text', 'label' => 'Lead in', 'required' => false,
                                  'description' => 'A few words before the number. Optional.'],
                ],
            ],
        ];
    }

    /**
     * Its stylesheet, in the head of a **visitor's** page
     *
     * Not `assets()`, which is the admin's. The value is the needle: `reading-time` is the
     * class the badge above writes, so a site with this plugin enabled and no badge on the
     * page loads nothing at all.
     */
    public function pageAssets(): array {
        return ['reading-time.css' => 'reading-time'];
    }

    /** Its widget has a button, and a button needs a listener */
    public function assets(): array {
        return ['reading-time.js'];
    }

    public function entities(): array {
        return [Entity\ReadingTime::class];
    }

    public function migrations(): array {
        return [Migration\CreateReadingTimeTable::class];
    }

    public function controllers(): array {
        return [ReadingTimeController::class];
    }

    public function permissions(): array {
        return [self::PERMISSION => 'reading_time'];
    }

    /**
     * The imperative half: a field on the content form, and a service to answer for it
     *
     * A Micro callable rather than a closure, so nothing here is built until an admin actually
     * opens a content editor. A visitor reading a post pays for none of it.
     */
    public function register(): void {
        Micro::get(\Dynart\Micro\EventServiceInterface::class)->subscribe(
            FormFactory::eventName(AdminForms::CONTENT), [self::class, 'onContentForm']
        );
    }

    /**
     * Adds the field to a form this plugin did not write
     *
     * `addFields(..., false)` so it is optional - a required field added by a plugin would stop
     * anybody saving a post until they filled it in.
     */
    public function onContentForm(DpressForm $form, array $context): void {
        $content = $context['content'] ?? null;
        $form->addFields([
            'reading_time' => [
                'type' => 'reading_time',
                'label' => 'Reading time',
                'required' => false,
                'description' => 'Leave empty to work it out from the text.',
            ],
        ], false);
        if ($content !== null) {
            $form->addValues([
                'reading_time' => (string)(Micro::get(ReadingTimeService::class)->storedMinutes($content->id) ?? ''),
            ]);
        }
    }
}

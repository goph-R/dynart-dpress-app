<?php

/**
 * Fills a freshly installed database with the example data
 *
 * Goes through the services rather than writing rows, so the events fire and the audit trail
 * looks like a real site's - which is the point of having example data at all.
 *
 *   php database/seed.php
 *
 * `database/reset.sh` (or reset.bat) drops the database, installs, seeds, and dumps the result
 * to example-data.sql. Regenerate that file whenever the entities change; there is no rename
 * migration before 1.0.
 */

use Dynart\Micro\Micro;
use Dynart\Micro\Entities\AuditService;
use Dynart\Dpress\DpressCliApp;
use Dynart\Dpress\Entity\Content;
use Dynart\Dpress\Entity\Role;
use Dynart\Dpress\Entity\User;
use Dynart\Dpress\Service\ContentService;
use Dynart\Dpress\Service\UserService;

require_once __DIR__ . '/../vendor/autoload.php';

$app = new DpressCliApp([__DIR__ . '/../dpress.ini']);
$app->fullInit();

$users = Micro::get(UserService::class);
$content = Micro::get(ContentService::class);
$audit = Micro::get(AuditService::class);

echo "Seeding example data\n";

// --- Users -------------------------------------------------------------------------------

$admin = $users->findByEmail('admin@example.com')
    ?? $users->create('admin@example.com', 'admin12345', 'Site Admin', [Role::NAME_ADMIN]);
echo "  user  admin@example.com   / admin12345   (admin)\n";

$editor = $users->findByEmail('editor@example.com')
    ?? $users->create('editor@example.com', 'editor12345', 'Edit Everything', [Role::NAME_EDITOR]);
echo "  user  editor@example.com  / editor12345  (editor)\n";

$reader = $users->findByEmail('reader@example.com')
    ?? $users->create('reader@example.com', 'reader12345', 'Ray Reader', [Role::NAME_READER]);
echo "  user  reader@example.com  / reader12345  (reader)\n";

$pending = $users->findByEmail('pending@example.com')
    ?? $users->create('pending@example.com', 'pending12345', 'Penny Pending', [Role::NAME_READER], User::STATUS_PENDING);
echo "  user  pending@example.com / pending12345 (reader, pending - cannot log in)\n";

// --- Content -----------------------------------------------------------------------------

$posts = [
    [
        'title' => 'Welcome to dpress',
        'author' => $admin,
        'publish' => true,
        'markdown' => <<<'MD'
This is the lead. Everything before the separator shows up in listings, and only that.

---

## And this is the body

The body is everything after the first line that is nothing but three dashes. A post with no
separator is all lead and no body, which is exactly what a short note is.

Markdown works as you would expect: **bold**, *italic*, `inline code` and [links](https://example.com).

- a list item
- another one

> A blockquote, for good measure.
MD
    ],
    [
        'title' => 'Árvíztűrő tükörfúrógép',
        'author' => $editor,
        'publish' => true,
        'markdown' => <<<'MD'
Az ékezetes címekből is olvasható URL lesz, mert a slug az ékezeteket az alapbetűre képezi le.

---

Ez a törzsszöveg. A cím slugja `arvizturo-tukorfurogep` lett, nem pedig kötőjelek sora.
MD
    ],
    [
        'title' => 'A short note',
        'author' => $editor,
        'publish' => true,
        'markdown' => 'No separator here, so the whole thing is the lead and there is no body.',
    ],
    [
        'title' => 'Something unfinished',
        'author' => $admin,
        'publish' => false,
        'markdown' => "A draft. Visitors get a 404; anybody who may edit posts can preview it.\n\n---\n\nStill being written.",
    ],
];

foreach ($posts as $data) {
    if ($content->findBySlug($data['title'], false) !== null) {
        continue;
    }
    $created = $content->create([
        'type'     => Content::TYPE_POST,
        'title'    => $data['title'],
        'markdown' => $data['markdown'],
        'status'   => $data['publish'] ? Content::STATUS_PUBLISHED : Content::STATUS_DRAFT,
    ], $data['author']->id);
    echo "  post  /{$created->slug} ({$created->status})\n";
}

// --- A page, and a child of it -----------------------------------------------------------

$about = $content->findBySlug('about', false);
if ($about === null) {
    $about = $content->create([
        'type'     => Content::TYPE_PAGE,
        'title'    => 'About',
        'markdown' => "About this site.\n\n---\n\nPages are hierarchical. This one has a child.",
        'status'   => Content::STATUS_PUBLISHED,
    ], $admin->id);
    echo "  page  /{$about->slug}\n";
}

if ($content->findBySlug('contact', false) === null) {
    $contact = $content->create([
        'type'      => Content::TYPE_PAGE,
        'title'     => 'Contact',
        'markdown'  => 'How to get in touch.',
        'status'    => Content::STATUS_PUBLISHED,
        'parent_id' => $about->id,
    ], $admin->id);
    echo "  page  /{$about->slug}/{$contact->slug} (child of About)\n";
}

// --- A second revision, so the history has something in it --------------------------------

$welcome = $content->findBySlug('welcome-to-dpress', false);
if ($welcome !== null) {
    $audit->reset(); // a new revision, so the edit is its own entry rather than folded into the create
    $audit->setUserId((string)$editor->id);
    $content->update($welcome, ['title' => 'Welcome to dpress!']);
    echo "  edit  /welcome-to-dpress - a second revision, by the editor\n";
}

echo "Done. Try: dpress content:list, dpress content:history -id 1\n";

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
use Dynart\Dpress\Service\MediaService;
use Dynart\Dpress\Service\MenuService;
use Dynart\Dpress\Service\SettingService;
use Dynart\Dpress\Service\TaxonomyService;
use Dynart\Dpress\Service\UserService;

require_once __DIR__ . '/../vendor/autoload.php';

$app = new DpressCliApp([__DIR__ . '/../dpress.ini']);
$app->fullInit();

$users = Micro::get(UserService::class);
$content = Micro::get(ContentService::class);
$audit = Micro::get(AuditService::class);
$taxonomy = Micro::get(TaxonomyService::class);
$media = Micro::get(MediaService::class);
$menus = Micro::get(MenuService::class);
$settings = Micro::get(SettingService::class);

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

// --- Taxonomy ---------------------------------------------------------------------------

$news = $taxonomy->findCategoryBySlug('news') ?? $taxonomy->createCategory('News');
$guides = $taxonomy->findCategoryBySlug('guides') ?? $taxonomy->createCategory('Guides');
$howTo = $taxonomy->findCategoryBySlug('how-to') ?? $taxonomy->createCategory('How to', ['parent_id' => $guides->id]);
echo "  cat   /news, /guides, /guides > /how-to
";

$welcome = $content->findBySlug('welcome-to-dpress', false);
if ($welcome !== null) {
    $taxonomy->setCategories($welcome->id, [$news->id]);
    $taxonomy->setTags($welcome->id, ['dpress', 'markdown', 'getting started']);
    echo "  tags  /welcome-to-dpress: dpress, markdown, getting started
";
}
$note = $content->findBySlug('a-short-note', false);
if ($note !== null) {
    $taxonomy->setCategories($note->id, [$news->id]);
    $taxonomy->setTags($note->id, ['dpress']);
}
$accented = $content->findBySlug('arvizturo-tukorfurogep', false);
if ($accented !== null) {
    $taxonomy->setCategories($accented->id, [$howTo->id]);
    $taxonomy->setTags($accented->id, ['markdown']);
}

// --- Media ------------------------------------------------------------------------------

$examples = __DIR__ . '/media';
if (is_dir($examples) && $welcome !== null) {
    foreach (glob($examples . '/*') as $file) {
        if ($media->findByPath(basename($file)) !== null) {
            continue;
        }
        $item = $media->importFile($file, $admin->id, ['alt' => 'Example ' . pathinfo($file, PATHINFO_FILENAME)]);
        echo "  media {$item->path} ({$item->category})
";
        if ($item->isImage() && $welcome->featured_media_id === null && $item->isResizable()) {
            $content->update($welcome, ['featured_media_id' => $item->id]);
        } else {
            $media->attach($welcome->id, $item->id);
        }
    }
}

// --- Settings and menus -------------------------------------------------------------------

$settings->set(\Dynart\Dpress\Entity\Setting::SITE_NAME, 'dpress dev');
$settings->set(\Dynart\Dpress\Entity\Setting::REGISTRATION_OPEN, '1');
echo "  set   site_name, registration_open
";

if ($menus->findMenuByPlace('main') === null) {
    $main = $menus->createMenu('Main', 'main');
    $menus->addItem($main, ['label' => 'Home', 'target_type' => 'home', 'position' => 0]);
    if ($about !== null) {
        $menus->addItem($main, ['label' => 'About', 'target_type' => 'content', 'target_id' => $about->id, 'position' => 1]);
    }
    $menus->addItem($main, ['label' => 'News', 'target_type' => 'category', 'target_id' => $news->id, 'position' => 2]);
    echo "  menu  Main -> place 'main': Home, About, News
";
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

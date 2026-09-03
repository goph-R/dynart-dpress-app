# gopherlab

The gopherlab.net design, ported to dpress. Built from the running site — the colours and the type
scale below are what the pages actually compute, read off the live CSS rather than matched by eye,
then checked against full-page screenshots of the front page and a post.

```
theme.ini                    five places: main, social, sidebar, home_top, footer
assets/style.css             the whole design, served at /assets/theme/style.css
dpress/layout.phtml          the reading column - a post, a page, an archive, the account screens
dpress/layout-home.phtml     the front page: the same columns plus the featured strip
dpress/content/list.phtml    the front page and the archives
dpress/content/single.phtml  a post
dpress/content/page.phtml    a page
partial/head.phtml           what both layouts share above the fold
partial/header.phtml         the brand, the social place, the menu bar
partial/footer.phtml         three columns of the footer place, then the small print
```

## The palette

Dracula, on a near-black page. Every value here was taken from the site's computed styles.

| | | |
|---|---|---|
| page | `#0e0e1c` | behind everything |
| bars | `#21222c` | header, menu, footer |
| content area | `#282a36` | Dracula's own background - the whole two-column region, not a card |
| borders | `#44475a`, `#6272a4` | frames, and the rule under a widget title |
| text | `#e2d9d9` | and `#7d7d7d` for meta |
| headings | `#ffb86c` | Dracula orange |
| links | `#00c6e0`, hover `#70d3e0` | |
| widget titles | `#f1fa8c` | Dracula yellow, uppercase |

Type: **Inter** for the body at 16px/1.5 and 17px/1.7 in an article, **Roboto Condensed** 700 for
every heading. Neither font is shipped — the stacks in `:root` fall back to the system's condensed
and UI faces. Drop `Inter.woff2` and `RobotoCondensed.woff2` into `assets/` and uncomment the
`@font-face` block at the top of the stylesheet; they are served from the same URL as the
stylesheet, so nothing else has to change.

## The two layouts

`layout-home.phtml` is the front page and `layout.phtml` is everything else. They share the same
two columns — 70.3125% / 29.6875% from 768px, the original's proportions — and differ in one
thing: the front page has the **featured strip** on top of them.

The strip is markup no other page has, which is what makes this two files rather than one file
with an `if` in it. `content/list.phtml` fills a `featured` block and the home layout prints it
above the columns, because the strip is wider than the column the content is in — and it carries
**the same 70/30 split**, so the large card lines up with the article column and the four small
ones line up with the sidebar. It is the top of both columns rather than a band across them.

The surface is worth knowing: `#282a36` is on the **whole content area**, not on the article. So a
post is text on the page it belongs to rather than a card floating on a background, and a listing
sits on the same surface as the sidebar beside it.

**A category or a tag reads like a post**, which is a decision expressed by *not* writing
`layout-archive.phtml`: with no file for that kind, the resolution falls back to `layout.phtml`.

## The places

| Place | Drawn by | For |
|---|---|---|
| `main` | both, in the bar under the header | the site's menu |
| `social` | both, in the header | a menu of GitHub / YouTube / X links |
| `sidebar` | both | recent posts, categories, a Ko-fi block |
| `home_top` | **the front page only** | anything that belongs there and nowhere else |
| `footer` | both, in three columns above the copyright bar | categories, support, whatever else |

`home_top` is the point worth knowing: a place only one layout renders is a place that only
appears there. No visibility rule, nothing to configure.

The original's footer is a single copyright bar — its theme has a widget area and the site leaves
it empty. Here the three columns render only when the `footer` place has something in it, so an
empty place gives you the original's bar exactly.

## Featured posts

Tag a post `featured` and it goes to the top of the front page — one large card and up to four
small ones — and is left out of the list below, because pinned *and* repeated four rows down reads
as a bug. The tag is the `featured_tag` setting, so it can be renamed or emptied.

Below 1025px the four small cards are hidden and the large one stands alone, which is what the
original does.

**A featured post need not have a picture.** The large card puts its title *over* the image, so
with no image it puts it in a panel of its own instead — `has-image` on the card decides which,
and without it an absolutely positioned overlay would leave a card with no height, which is a post
that has silently vanished from the front page. The same for the small cards: no picture, no
thumbnail column.

A post whose picture is in the **media bin** counts as having none. `MediaService::findByIds()`
skips soft-deleted items, the same rule the site logo follows — something somebody put in the bin
should leave the page rather than wait for a purge. Restore it from the media screen and the card
takes its picture back.

## What the original has and this does not

Honest list, so nothing is a surprise later:

- **Comments**, and the comment count on a card. That is the Disqus plugin — see
  `docs/comments.md` in dpress.
- **Post navigation** — the previous/next post links under an article. There is no query for the
  adjacent post yet.
- **The author's name** in the meta line. A listing row carries `author_id` and nothing resolves it
  for a template; the date and the categories are there.
- **Search**, which the original has in its menu bar.
- The author bio box and the featured image on a single post are **deliberately** absent — the
  original hides both in its own custom CSS.

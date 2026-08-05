# A dpress site

The runnable site: a thin shell around [dpress](https://github.com/goph-R/dynart-dpress) holding
the configuration, the themes, the uploads and the front controller.

## Setting one up

```bash
composer install --no-dev -o
cp dpress.ini.example dpress.ini
```

Then edit `dpress.ini` — every value that has to change is commented in it. The three that are
not optional on a real site:

- `app.root_path` and `app.base_url`, which everything else is resolved against
- the `database.default.*` block, pointing at a database you have already created
- `jwt.secret`, which signs every session: `php -r "echo bin2hex(random_bytes(32));"`

**`dpress.ini` is not in git**, on purpose. It holds a password and a secret, and the only copy
that matters is the one on the machine it belongs to. `dpress.ini.example` is the shape of it.

Then create the schema and somebody to log in as:

```bash
vendor/bin/dpress install
vendor/bin/dpress user:create -email you@example.com -name "Your Name" -role admin
```

Leaving `-password` off generates one and prints it, so it never reaches your shell history.

## Serving it

The document root is **`public/`**, never this folder — `dpress.ini`, `logs/` and `database/`
sit here, and they are all readable over HTTP if the docroot is one level too high.

Apache needs `AllowOverride All` (the routing is in `public/.htaccess`), plus `mod_rewrite` and
`mod_headers`. `logs/` and `public/uploads/` have to be writable by the web user.

`vendor/bin/dpress install` writes `public/uploads/.htaccess` itself, which is what keeps an
uploaded file from ever being executed. Its first line is `php_flag engine off`, a mod_php
directive: under PHP-FPM Apache does not know it and every request into `uploads/` becomes a
500. On FPM, delete that line — the `<FilesMatch>` rule below it already denies `.php` outright.

## Updating

```bash
git pull
composer update --no-dev
vendor/bin/dpress upgrade      # applies whatever migrations are new
```

## Development

The dev site runs against `dpress_dev` with `app.environment = dev`, `mail.mailer = log` and a
throwaway JWT secret. The example content and the database reset script are documented in
[database/README.md](database/README.md).

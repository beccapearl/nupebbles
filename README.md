# NuPebbles website

The studio site: a landing page listing every app, and a privacy policy,
support page and FAQ for each one. It is built by GitHub Pages from the files
in this folder — there is nothing to install and no build step. Push, and it
publishes.

The privacy policy is written **once**, in `_layouts/privacy.html`. Each app
supplies only what differs (its name, what it stores, whether it makes files,
sends reminders, or uses marketplace purchases) in one small file under
`_data/apps/`. Nobody copies policy text.

## Adding a new app

Say the app is called **PebbleCount**. Choose a short lowercase key with no
spaces — `pebblecount`. Two steps:

**1. Copy `_data/apps/brighttend.yml` to `_data/apps/pebblecount.yml`.** Change
every value. The filename is the app key:

```yaml
key: pebblecount
name: PebbleCount
tagline: A clear, short description
blurb: One honest sentence about the app's useful features.
ios_store_url:                 # fill when the iOS version ships
android_store_url:             # fill when the Android version ships
accent: "#4A5A8A"
stores: the counters you create and your settings
makes_files: false             # true if it exports a backup, PDF, or other file
has_reminders: false           # true if it schedules local notifications
has_purchases: false           # true if it checks/buys/restores a marketplace purchase
collects_nothing: true         # see "Apps that don't fit" below
```

`stores` is dropped into the sentence *"Everything you enter — … — is saved in
the app's own private storage on your device"*, so write it to read well there.
The `makes_files`, `has_reminders`, and `has_purchases` flags switch whole
sections of the policy on or off, so they must be accurate. `true`/`false`
without quotes.

**2. Copy the folder `apps/brighttend/` to `apps/pebblecount/`.** In each of
the three files inside, change the one line `app: brighttend` to
`app: pebblecount`. That is the whole procedure. Then replace the help text in
`support.md` and the questions in `faq.md` with PebbleCount's own;
`privacy.md` needs nothing — its policy comes from the shared layout.

```
apps/pebblecount/privacy.md      front matter only
apps/pebblecount/support.md      front matter, then PebbleCount's own help text
apps/pebblecount/faq.md          front matter, then "## Question?" / answer pairs
```

For example, `privacy.md` in its entirety:

```
---
layout: privacy
app: pebblecount
title: Privacy Policy
---
```

The page's address comes from where the file sits: `apps/pebblecount/privacy.md`
is published at `/apps/pebblecount/privacy/`. Nothing else decides that, so two
apps can never end up at the same address. If the `app:` line is missing or
doesn't match a file under `_data/apps/`, the page shows a red notice instead of a
policy, so you'll see the mistake rather than publish it.

**Push.** The landing page picks the app up automatically, its three pages
appear at `/apps/pebblecount/privacy/`, `/support/` and `/faq/`, and the tabs
between them link themselves up.

**When the app ships,** paste its store links into `ios_store_url` and/or
`android_store_url`. The landing card shows each available marketplace and says
"Coming soon" only while both are empty.

### Apps that don't fit

Everything in the shared policy assumes the app does not collect user content:
no developer account, data server, analytics, advertising, or tracking. A
marketplace purchase connection is covered separately by `has_purchases`.
That is true of every NuPebbles app so far, and `collects_nothing: true` says so.

If an app is ever built that genuinely does something else — syncs through
iCloud, talks to a server, uses a third-party service — the shared wording
would be false for it, and a false policy is worse than no policy. For that
app, set `collects_nothing: false` and write its policy yourself in its own
`privacy.md`, under the front matter. The shared claims are left out for that
app; the heading, effective date, "Changes to this policy" and "Contact"
sections stay, so it still looks and reads like the others.

## Changing the policy for every app at once

1. Edit the wording in `_layouts/privacy.html`. It is plain HTML with the
   app's details filled in by `{{ app.name }}`-style placeholders; the comment
   at the top lists them.
2. Change `privacy_effective_date` in `_config.yml` to today.
3. Push. Every app's policy now shows the new text and the new date.

The support page's contact wording lives in `_layouts/support.html`, the
support address in `_config.yml`, and the look of everything in
`assets/css/main.css`.

Shared privacy and support copy must stay platform-neutral: say **"your device"**
and **"your device's app marketplace"**, not a specific phone, operating system,
or store. App-specific help may name a platform only when the instructions truly
differ. The policy promises no website tracking, so nothing on the site may load
a script, font, or image from anywhere else.

## Publishing

The site is published from the `main` branch of the `nupebbles` repository on
GitHub. **Every time you change something: push to `main`.** GitHub rebuilds
the site within a couple of minutes. There is nothing else to do.

If Pages ever needs re-enabling: on GitHub, **Settings → Pages → Build and
deployment**. Source: *Deploy from a branch*. Branch: *main*, folder */ (root)*.
Save. The repository has to stay public for GitHub Pages on a free account.

**Custom domain, when you have one:** GitHub → Settings → Pages → Custom
domain, enter it and follow the DNS instructions shown, then tick *Enforce
HTTPS*. No file in this folder needs to change — the site works out its own
address from the repository settings, which is why `_config.yml` has no
`url` or `baseurl` line. Don't add one.

## Previewing on your own computer (optional)

```
bin/preview
```

then open <http://127.0.0.1:4000/nupebbles/>. It needs Ruby and Bundler (from
Homebrew: `brew install ruby`). The first run downloads what it needs into
`vendor/`; after that it rebuilds as you edit (reload the browser to see
changes). Stop it with Ctrl-C. Skipping this changes nothing about publishing.

## Files

```
_config.yml              site name, support email, policy effective date
_data/apps/<key>.yml     one small data file per app
_layouts/default.html    page frame: header, footer, stylesheet
_layouts/privacy.html    THE privacy policy, shared by every app
_layouts/support.html    shared contact block around each app's help text
_layouts/faq.html        frame for each app's questions and answers
_includes/               small shared pieces (app header, the Privacy/Support/FAQ tabs, the setup-error notice)
assets/css/main.css      the one stylesheet
index.html               landing page; lists every app in _data/apps/
apps/<key>/privacy.md    stub: front matter only
apps/<key>/support.md    stub + that app's help text
apps/<key>/faq.md        stub + that app's questions and answers
bin/preview              local preview script (not part of the site)
Gemfile                  local preview only; GitHub ignores it
```

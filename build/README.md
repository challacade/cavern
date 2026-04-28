# Cavern Web Build

These scripts package Cavern into a browser-playable bundle using
[love.js](https://github.com/Davidobot/love.js), the WebAssembly port of LÖVE.

The web build is **optional** — Cavern still runs natively on any platform
that supports LÖVE 11+. These scripts are provided as a convenience for
anyone who wants to host the game in a browser.

## Prerequisites

- Windows (the helper scripts are `.bat` files; on other platforms see the
  [Manual one-liner](#manual-one-liner) below).
- [Node.js](https://nodejs.org/) (any recent LTS). `npx` is used to fetch
  `love.js` on first run.
- A local web server: Python 3 or Node.js (used by `web-run.bat`).

## Building

From the repository root:

```
build\web-build.bat
```

The script will:

1. Zip the project's source folders (`main.lua`, `conf.lua`, `source/`,
   `sprites/`, `fonts/`, `sounds/`, `music/`, `maps/`) into `build/game.love`.
2. Run `npx love.js` to convert that archive into a browser bundle at
   `build/web-output/` (containing `index.html`, `love.js`, `love.wasm`,
   `game.js`, `game.data`, and a `theme/` folder).

## Running locally

```
build\web-run.bat
```

This starts a local HTTP server on <http://localhost:8080> serving
`web-output/`. A static file server is required — opening `index.html`
directly via `file://` will not work because love.js fetches `game.data`
at runtime.

## Manual one-liner

If you'd rather not use the helper scripts:

```
# from the repo root, after creating game.love yourself
npx love.js -t "Cavern" -c game.love web-output
```

## Hosting the web build

The contents of `web-output/` are static files and can be uploaded to any
static host (GitHub Pages, Netlify, S3, your own server, etc.).

If your URL has a trailing-slash variant (e.g. `example.com/cavern` vs
`example.com/cavern/`), add a `<base href="/your/path/">` tag to the
generated `index.html` so its relative asset paths resolve correctly.

## License note for redistributors

This `build/` folder and its scripts are MIT-licensed along with the rest
of the code in `source/`. **However**, running these scripts produces a
bundle that includes Cavern's art, music, and sound assets, which are
licensed [CC BY-NC-ND 4.0](../sprites/LICENSE.txt). If you host or
redistribute the resulting `web-output/`, you are redistributing those
assets and must comply with their license terms (attribution,
non-commercial, no derivatives). See the `LICENSE.txt` files in `sprites/`,
`music/`, `sounds/`, and `maps/` for details.

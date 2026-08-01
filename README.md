# neovim-wrapper

My custom Neovim config wrapped as a nix package using
[nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules).

Run it from anywhere nix is installed in a single command:

```nix
nix run github:zenoli/neovim-wrapper
```

## Table of Contents

<!--toc:start-->

- [neovim-wrapper](#neovim-wrapper)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Quick Start](#quick-start)
    - [Hacking on the config](#hacking-on-the-config)
  - [Directory Structure](#directory-structure)
  - [Documentation](#documentation)
  - [Credits](#credits)

<!--toc:end-->

## Features

- **Reproducible installs** — plugins and tools (LSP servers, formatters, linters, test
  runners) are declared in Nix and pinned via [`flake.lock`](flake.lock).
- **Lua for everything else** — editor behavior, keymaps, and plugin wiring are plain
  Lua under [`lua/`](lua/README.md).
- **Fast dev iteration** — the `neovim-dev` package (the `devDir` option in
  [`nix/wrapper/default.nix`](nix/wrapper/default.nix)) points Neovim at this repo's
  path on disk, so it reads Lua config live without a rebuild.
- **Baked in by default** — the default package copies the Lua config into the Nix store
  at build time, giving you an immutable, reproducible package.
- **Language centered config** — each programming language's config lives in its own
  module under [`lua/lang/`](lua/lang/README.md).

## Quick Start

Build and run it locally:

```bash
nix run
```

or from anywhere:

```bash
nix run github:zenoli/neovim-wrapper
```

Build it once and inspect the result:

```bash
nix build
./result/bin/nvim
```

### Hacking on the config

The default package bakes the Lua config into the Nix store — editing Lua requires a
rebuild. For development there is a second package, `neovim-dev`, which reads the Lua
config live from this repo's working tree (`devDir` in
[`nix/wrapper/default.nix`](nix/wrapper/default.nix)); Lua edits apply as soon as you
restart neovim (`:restart`).

The dev shell (`nix develop`) provides both as single commands:

```bash
dev   # run the neovim-dev package (live Lua config from the working tree)
run   # run the default package (config baked into the Nix store)
```

Outside the shell the equivalents are `nix run .#neovim-dev` and `nix run .`
respectively.

If you fork this repo, update `devDir` in the `neovim-dev` wrapper
([`flake.nix`](flake.nix)) to point at your own clone.

## Directory Structure

```
.
├── init.lua          # entrypoint: sets up lazy-loading, loads plugins + lang specs
├── lua/              # Pure lua configuration. See lua/README.md
│   ├── lang/         # language-specific config, one folder per language — see lua/lang/README.md
│   └── plugins/      # general language-agnostic plugins (colorscheme, git, statusline, ...)
├── nix/              # Nix configuration. See nix/README.md
│   ├── wrapper/      # plugin/tool declarations + language module wiring
│   └── shell.nix     # dev shell
└── flake.nix         # exports the package + nixos/home-manager modules
```

## Documentation

- [lua/README.md](lua/README.md) — Pure lua configuration: general plugins, language
  config, LSP keymaps.
- [nix/README.md](nix/README.md) — Nix configuration of the wrapper: Installation of
  neovim plugins and tools (lsp, linters, formatters etc.) declarations, dev shell.

## Credits

Built on [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) and
[lze](https://github.com/BirdeeHub/lze) for lazy loading.

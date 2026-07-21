# neovim-wrapper

My custom Neovim config wrapped as a nix package using
[nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules).

Run it from anywhere nix is installed in a single command:

```nix
nix run github:zenoli/neovim-wrapper
```

## Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Directory Structure](#directory-structure)
- [Documentation](#documentation)
- [Credits](#credits)

## Features

- **Reproducible installs** — plugins and tools (LSP servers, formatters, linters, test
  runners) are declared in Nix and pinned via `flake.lock`.
- **Lua for everything else** — editor behavior, keymaps, and plugin wiring are plain
  Lua under `lua/`.
- **Fast dev iteration** — `config.settings.config_directory`
  (`nix/wrapper/default.nix`) can point at this repo's path on disk, so Neovim reads Lua
  config live without a rebuild.
- **Bake it in when done** — remove that override and the Lua config is copied into the
  Nix store at build time, giving you an immutable, reproducible package.

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

Install it permanently on NixOS or via home-manager:

```nix
{
  imports = [ nix-wrapper-neovim.nixosModules.default ]; # or .homeModules.default
}
```

A dev shell (`nix develop`) provides a `plugin-name` helper for looking up a plugin's
`pname` in `nixpkgs#vimPlugins`.

If you fork this repo, update or remove the `config_directory` override in
`nix/wrapper/default.nix` to point at your own clone (or drop it to always build from
committed source).

## Directory Structure

```
.
├── init.lua          # entrypoint: sets up lazy-loading, loads plugins + lang specs
├── lua/              # Pure lua configuration. See lua/README.md
│   ├── lang/         # language-specific config, one folder per language — see lua/lang/README.md
│   └── plugins/      # general, always-on plugins (colorscheme, git, statusline, ...)
├── nix/              # Nix configuration. See nix/README.md
│   ├── wrapper/      # plugin/tool declarations + language module wiring
│   └── shell.nix     # dev shell
└── flake.nix         # exports the package + nixos/home-manager modules
```

## Documentation

- [lua/README.md](lua/README.md) — Pure lua configuration: general plugins, language
  config, LSP keymaps.
  - [lua/lang/README.md](lua/lang/README.md) — the `LangSpec` contract and how to add or
    remove a language.
- [nix/README.md](nix/README.md) — Nix configuration of the wrapper: Installation of
  neovim plugins and tools (lsp, linters, formatters etc.) declarations, dev shell.

## Credits

Built on [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) and
[lze](https://github.com/BirdeeHub/lze) for lazy loading.

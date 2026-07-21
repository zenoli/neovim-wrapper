# neovim-wrapper

<!--toc:start-->

- [neovim-wrapper](#neovim-wrapper)
- [Table of Contents](#table-of-contents)
- [Features](#features)
- [Quick Start](#quick-start)
- [Directory Structure](#directory-structure)
- [Core Plugins](#core-plugins)
- [Language Configs](#language-configs)
- [Credits](#credits)

<!--toc:end-->

A Neovim configuration built as a
[nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) `neovim`
wrapper.

## Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Directory Structure](#directory-structure)
- [Core Plugins](#core-plugins)
- [Language Configs](#language-configs)
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
├── init.lua                   # entrypoint: sets up lazy-loading, loads plugins + lang specs
├── lua/
│   ├── plugins/                # general, always-on plugins (colorscheme, git, statusline, ...)
│   ├── lsp/                    # global LSP keymaps
│   └── lang/
│       ├── init.lua            # discovers language modules at runtime
│       ├── types.lua           # LangSpec type definition
│       ├── config/
│       │   └── <lang>/         # one folder per language (e.g. python, latex, lua, nix)
│       │       ├── default.nix    # nix: language-specific plugins + runtimePkgs
│       │       ├── init.lua       # LangSpec table: lsp / test / format / lint
│       │       └── plugins/       # optional: extra plugins unique to this language
│       └── plugins/
│           ├── lsp/             # core plugin: nvim-lspconfig
│           ├── conform/         # core plugin: conform.nvim
│           ├── nvim-lint/       # core plugin: nvim-lint
│           └── neotest/         # core plugin: neotest
├── nix/
│   ├── wrapper/
│   │   ├── default.nix         # wires up language modules + config_directory
│   │   ├── plugins.nix         # general plugin list (specs.general)
│   │   └── tools.nix           # general runtimePkgs (lazygit, tree-sitter, ...)
│   └── shell.nix                # dev shell
├── flake.nix                    # exports the package + nixos/home-manager modules
└── docs/
    └── language-configs.md      # LangSpec fields, adding/removing a language
```

## Core Plugins

Four plugins are language-extensible: each has a **loader** that scans every language's
`LangSpec` (see [Language Configs](#language-configs)) and aggregates the relevant field
into that plugin's setup.

| Plugin | LangSpec field | Behavior | |---|---|---| | nvim-lspconfig | `lsp` |
Registers & enables each server via `vim.lsp.config` | | conform.nvim | `format` | Maps
formatters by filetype | | nvim-lint | `lint` | Maps linters by filetype | | neotest |
`test` | Registers one adapter per language |

## Language Configs

Config splits into two kinds:

- **General** (`lua/plugins/`) — plugins with no language coupling: colorscheme,
  statusline, git integration, etc. Always loaded.
- **Language-specific** (`lua/lang/config/<lang>/`) — plugins and tools only needed for
  one language. Everything for a language lives in its own folder, so deleting it
  removes that language completely: no leftover config, no zombie references elsewhere
  in the tree.

See [docs/language-configs.md](docs/language-configs.md) for the `LangSpec` schema and
how to add or remove a language.

## Credits

Built on [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) and
[lze](https://github.com/BirdeeHub/lze) for lazy loading.

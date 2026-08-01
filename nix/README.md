# Nix Configuration

This is the Nix half of the config — it declares what gets installed (plugins, LSP
servers, formatters, linters, test runners) and wraps it into a reproducible Neovim
package via [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules). The
Lua half ([`lua/`](../lua/)) is the config-directory content this wraps; see
[lua/README.md](../lua/README.md).

Per-language Nix wiring (`default.nix` in each `lua/lang/config/<lang>/`) is colocated
with that language's Lua config, not here — see
[lua/lang/README.md](../lua/lang/README.md).

## [`wrapper/`](wrapper/)

- [`default.nix`](wrapper/default.nix) — the wrapper module: imports every language's
  `default.nix` (found by listing [`lua/lang/config/`](../lua/lang/config/) via
  `readDir`), and sets the
  [neovim wrapper module options](https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/neovim.html).
  It also declares the `devDir` option: `null` (the default) bakes the Lua config into
  the store via the flake's own source snapshot; a path string makes Neovim read the
  Lua config live from that checkout instead (used by the `neovim-dev` wrapper in
  [`flake.nix`](../flake.nix), with an eval-time warning as a reminder).
- [`plugins.nix`](wrapper/plugins.nix) — `config.specs.general`: the general plugin
  list, matching [`lua/plugins/`](../lua/plugins/), independent of language.
- [`tools.nix`](wrapper/tools.nix) — `config.specs.tools`: general-purpose `runtimePkgs`
  not tied to any plugin or language (`lazygit`, `tree-sitter`).

## [`shell.nix`](shell.nix)

The `nix develop` dev shell for working on this repo itself. Provides:

- `dev` — runs the `neovim-dev` package (`nix run .#neovim-dev`): Neovim reads the Lua
  config live from the working tree, so Lua edits apply on the next launch without a
  rebuild.
- `run` — runs the default package (`nix run .#neovim`): the Lua config is baked into
  the Nix store as installed builds would have it.
- `plugin-name <vimPlugin-attr>` — looks up a plugin's `pname` in `nixpkgs#vimPlugins`
  — this can be useful, as the `pname` is what
  [lze](https://github.com/BirdeeHub/lze) expects in the `name` field for a plugin
  spec.

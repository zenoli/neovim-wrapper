# Nix Configuration

This is the Nix half of the config — it declares what gets installed (plugins, LSP
servers, formatters, linters, test runners) and wraps it into a reproducible Neovim
package via
[nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules). The Lua half
(`lua/`) is the config-directory content this wraps; see
[lua/README.md](../lua/README.md).

Per-language Nix wiring (`default.nix` in each `lua/lang/config/<lang>/`) is colocated
with that language's Lua config, not here — see
[lua/lang/README.md](../lua/lang/README.md).

## `wrapper/`

- `default.nix` — the wrapper module: imports every language's `default.nix` (found by
  listing `lua/lang/config/` via `readDir`), sets `config.settings.config_directory`
  (points Neovim at this repo's Lua on disk for live-reload dev iteration instead of
  copying it into the Nix store), and defines the `runtimePkgs` spec field used to
  suffix binaries onto `$PATH`.
- `plugins.nix` — `config.specs.general`: the always-on plugin list, matching
  `lua/plugins/`, independent of language.
- `tools.nix` — `config.specs.tools`: general-purpose `runtimePkgs` not tied to any
  plugin or language (`lazygit`, `tree-sitter`).

## `shell.nix`

The `nix develop` dev shell for working on this repo itself. Currently provides one
helper, `plugin-name <vimPlugin-attr>`, which looks up a plugin's `pname` in
`nixpkgs#vimPlugins` — useful when wiring a new plugin into `plugins.nix` or a
language's `default.nix` and you need the exact attribute name.

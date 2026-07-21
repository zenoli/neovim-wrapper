# Lua Configuration

This is the Lua half of the config — editor behavior, keymaps, and plugin wiring. The
Nix half declares what's installed and wraps it into a package; see
[nix/README.md](../nix/README.md).

All plugins are lazy loaded using [lze](https://github.com/BirdeeHub/lze)

## Structure

- [`lang/`](lang/) — language-specific config: LSP, formatting, linting, and testing,
  one folder per language. See [lang/README.md](lang/README.md).
- [`plugins/`](plugins/) — general, always-on plugins with no language coupling
  (colorscheme, git integration, statusline, completion, ...).
- [`lsp/`](lsp/) — global LSP keymaps and diagnostic config, wired up on every
  `LspAttach` regardless of language.
- [`colorscheme.lua`](colorscheme.lua), [`keymaps.lua`](keymaps.lua),
  [`options.lua`](options.lua) — flat, single-purpose files for editor-wide settings.

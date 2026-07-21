# Lua Configuration

This is the Lua half of the config — editor behavior, keymaps, and plugin wiring. The
Nix half declares what's installed and wraps it into a package; see
[nix/README.md](../nix/README.md).

## Structure

- [`lang/`](lang/) — language-specific config: LSP, formatting, linting, and testing,
  one folder per language. See [lang/README.md](lang/README.md).
- [`plugins/`](plugins/) — general, always-on plugins with no language coupling
  (colorscheme, git integration, statusline, completion, ...).
- [`lsp/`](lsp/) — global LSP keymaps and diagnostic config, wired up on every
  `LspAttach` regardless of language.
- [`colorscheme.lua`](colorscheme.lua), [`keymaps.lua`](keymaps.lua),
  [`options.lua`](options.lua) — flat, single-purpose files for editor-wide settings.

## Entry point

[`init.lua`](../init.lua) (repo root) enables lazy-loading via `lze`, then loads
[`colorscheme`](colorscheme.lua), [`plugins/*`](plugins/), and every language's specs
via [`lang.specs()`](lang/init.lua), followed by [`keymaps`](keymaps.lua),
[`options`](options.lua), and [`lsp`](lsp/init.lua).

# Language Configs

Each language lives in its own folder: `lua/lang/config/<lang>/`. Nothing about a language is referenced anywhere else in the repo — both the Nix and Lua sides discover language folders at build/run time by listing that directory, so adding or removing a language never requires touching any other file.

## Layout of a language folder

```
lua/lang/config/<lang>/
├── default.nix   # nix: extra vim plugins (config.specs.<lang>) + runtimePkgs (LSP server, formatter, linter, test binary, ...)
├── init.lua       # returns a LangSpec table
└── plugins/       # optional: plugins unique to this language (not one of the 4 core plugins)
```

- `default.nix` receives `inputs` (curried) and the usual module args (`pkgs`, `lib`, ...), in case the language needs an external flake input (see `latex`, which pulls in `nvim-texlabconfig` as a separate input and builds it via `pkgs/nvim-texlabconfig.nix`).
- `nix/wrapper/default.nix` imports every `<lang>/default.nix` automatically via `readDir`.
- `lua/lang/init.lua` requires every `<lang>/init.lua` automatically via `vim.fs.dir`, and also picks up anything in `<lang>/plugins/` as an `lze` spec.

## The `LangSpec` table

Defined in `lua/lang/types.lua`. All fields are optional — a language only sets the ones it needs:

| Field | Type | Consumed by |
|---|---|---|
| `lsp` | `table<string, vim.lsp.ClientConfig>`, keyed by server name | nvim-lspconfig loader |
| `format` | `string[]` (uses the language name as filetype) or `table<string, string[]>` (explicit filetypes) | conform.nvim loader |
| `lint` | `string[]` or `table<string, string[]>`, same shape as `format` | nvim-lint loader |
| `test` | `true` \| `LangTestSpec` \| `LangTestSpec[]` — `true` means "use `neotest-<lang>` with no config" | neotest loader |

`LangTestSpec` is `{ name?: string, config?: table }` — `name` overrides the adapter plugin name (default `neotest-<lang>`), `config` is passed to the adapter on `require`.

See [Core Plugins](../README.md#core-plugins) in the README for what each loader does with these fields.

## Optional `plugins/` subfolder

Use this for a plugin that's specific to one language but isn't one of the 4 core plugins — for example `latex/plugins/nvim-texlabconfig.lua`, which wires up SyncTeX forward/inverse search for LaTeX only. Files here follow the normal `lze.PluginSpec` shape, same as `lua/plugins/*.lua`.

## Adding a language

1. Create `lua/lang/config/<lang>/`.
2. Add `default.nix`: declare any extra Nix-level plugins under `config.specs.<lang>`, and list `runtimePkgs` for whatever binaries the tooling needs (LSP server, formatter, linter, test runner).
3. Add `init.lua` returning a `LangSpec` table with whichever of `lsp` / `format` / `lint` / `test` apply.
4. (Optional) Add `plugins/` for extra language-specific plugins.

## Removing a language

Delete `lua/lang/config/<lang>/`. Its Nix-level plugins and `runtimePkgs`, its LSP/format/lint/test wiring, and any language-unique plugins all disappear with it — there's no other place in the tree that references a language by name.

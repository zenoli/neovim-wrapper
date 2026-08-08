---@type LangSpec
return {
  lsp = {
    nixd = {
      filetypes = { "nix" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = [[import <nixpkgs> {}]],
          },
          options = {},
          formatting = {
            command = { "nixfmt" },
          },
          diagnostic = {
            suppress = {
              "sema-escaping-with",
            },
          },
        },
      },
    },
    devenv = {
      filetypes = { "nix" },
      cmd = { "devenv", "lsp" },
      root_markers = { "devenv.nix", "devenv.yaml" },
      -- `devenv lsp` just launches a plain nixd process; it doesn't push its
      -- own config into it. nixd pulls settings via workspace/configuration,
      -- so we fetch the project-specific config devenv would use and hand
      -- it to nixd ourselves, otherwise there's no nixpkgs/options context
      -- and completions/hover stay empty.
      --
      -- This has to happen in on_init rather than before_init: the client's
      -- `settings` field (what answers workspace/configuration requests) is
      -- snapshotted from config.settings when the client object is created,
      -- which happens before before_init runs. Mutating config.settings
      -- there is a no-op; on_init hands us the live client instead.
      on_init = function(client)
        local result = vim
          .system({ "devenv", "lsp", "--print-config" }, { cwd = client.config.root_dir, text = true })
          :wait()
        if result.code ~= 0 then
          vim.notify("devenv lsp --print-config failed: " .. (result.stderr or ""), vim.log.levels.WARN)
          return
        end
        local ok, settings = pcall(vim.json.decode, result.stdout)
        if ok then
          client.settings = settings
          client:notify("workspace/didChangeConfiguration", { settings = settings })
        end
      end,
    },
  },
}

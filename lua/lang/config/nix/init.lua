---@type LangSpec
return {
  lsp = {
    -- nixd = {
    --   filetypes = { "nix" },
    --   settings = {
    --     nixd = {
    --       nixpkgs = {
    --         expr = [[import <nixpkgs> {}]],
    --       },
    --       options = {},
    --       formatting = {
    --         command = { "nixfmt" },
    --       },
    --       diagnostic = {
    --         suppress = {
    --           "sema-escaping-with",
    --         },
    --       },
    --     },
    --   },
    -- },
    devenv = {
      filetypes = { "nix" },
      cmd = { "devenv", "lsp" },
      root_markers = { "devenv.nix", "devenv.yaml" },
      -- `devenv lsp` just launches a plain nixd process; it doesn't push its
      -- own config into it. nixd pulls settings via workspace/configuration,
      -- so we fetch the project-specific config devenv would use and hand
      -- it to nixd ourselves, otherwise there's no nixpkgs/options context
      -- and completions/hover stay empty.
      before_init = function(_, config)
        local result = vim.system({ "devenv", "lsp", "--print-config" }, { cwd = config.root_dir, text = true }):wait()
        if result.code ~= 0 then
          vim.notify("devenv lsp --print-config failed: " .. (result.stderr or ""), vim.log.levels.WARN)
          return
        end
        local ok, settings = pcall(vim.json.decode, result.stdout)
        if ok then
          config.settings = settings
        end
      end,
    },
  },
}

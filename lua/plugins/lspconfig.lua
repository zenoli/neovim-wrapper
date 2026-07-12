---@type lze.PluginSpec[]
return vim.list_extend(require("loaders.lsp").get_specs(), {
  {
    "nvim-lspconfig",
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
  },
})

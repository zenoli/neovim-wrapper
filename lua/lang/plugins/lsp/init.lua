---@type lze.PluginSpec[]
return vim.list_extend(require("lang.plugins.lsp.loader").get_specs(), {
  {
    "nvim-lspconfig",
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
  },
})

return {
  "nvim-lspconfig",
  lsp = function(plugin)
    vim.lsp.config(plugin.name, plugin.lsp or {})
    vim.lsp.enable(plugin.name)
  end,
}

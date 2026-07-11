local function get_lsp_specs()
  local lang_dir = require("nix-info").settings.config_directory .. "/lua/lang"
  local specs = {}
  for name, _ in vim.fs.dir(lang_dir) do
    local module_name = name:match("^(.+)%.lua$") or name
    if module_name then
      local lang = require("lang." .. module_name)
      if lang.lsp then
        for server_name, lsp_config in pairs(lang.lsp) do
          table.insert(specs, { server_name, lsp = lsp_config })
        end
      end
    end
  end
  return specs
end

return vim.list_extend(get_lsp_specs(), {
  {
    "nvim-lspconfig",
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
  },
})

---@return lze.PluginSpec[]
local function get_specs()
  local specs = {}
  for _, module in pairs(require("lang").load()) do
    if module.lsp then
      for server_name, lsp_config in pairs(module.lsp) do
        table.insert(specs, { server_name, lsp = lsp_config })
      end
    end
  end
  return specs
end

return { get_specs = get_specs }

---@param raw any
---@return { name?: string, config?: table }[]
local function normalize_specs(raw)
  if raw == true then
    return { {} }
  elseif vim.islist(raw) then
    return raw
  else
    return { raw }
  end
end

---@return { extensions: lze.PluginSpec[], adapter_specs: { name: string, config?: table }[] }
local function get_config()
  local extensions = {}
  local adapter_specs = {}
  for lang, module in pairs(require("lang").load()) do
    if module.test then
      for _, spec in ipairs(normalize_specs(module.test)) do
        local adapter_name = spec.name or ("neotest-" .. lang)
        table.insert(extensions, { adapter_name, dep_of = "neotest" })
        table.insert(adapter_specs, { name = adapter_name, config = spec.config })
      end
    end
  end
  return { extensions = extensions, adapter_specs = adapter_specs }
end

---@param adapter_specs { name: string, config?: table }[]
---@return neotest.Adapter[]
local function get_adapters(adapter_specs)
  return vim.tbl_map(function(spec)
    if spec.config ~= nil then
      return require(spec.name)(spec.config)
    else
      return require(spec.name)
    end
  end, adapter_specs)
end

return { get_config = get_config, get_adapters = get_adapters }

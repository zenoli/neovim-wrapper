local function get_lang_dir()
  return require("nix-info").settings.config_directory .. "/lua/lang"
end

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

---@return {
---extensions: lze.PluginSpec[],
---adapter_specs: { name: string, config?: table }[] }
local function get_neotest_config()
  local lang_dir = get_lang_dir()
  local extensions = {}
  local adapter_specs = {}
  for name, _ in vim.fs.dir(lang_dir) do
    local lang = name:match("^(.+)%.lua$") or name
    local module = require("lang." .. lang)
    if module.neotest then
      for _, spec in ipairs(normalize_specs(module.neotest)) do
        local adapter_name = spec.name or ("neotest-" .. lang)
        table.insert(extensions, { adapter_name, dep_of = "neotest" })
        table.insert(adapter_specs, { name = adapter_name, config = spec.config })
      end
    end
  end
  return {
    extensions = extensions,
    adapter_specs = adapter_specs,
  }
end

local config = get_neotest_config()

---@type lze.PluginSpec[]
return vim.list_extend(config.extensions, {
  {
    "neotest",
    keys = require("plugins.neotest.keymaps"),
    after = function()
      require("neotest").setup({
        adapters = vim.tbl_map(function(spec)
          if spec.config ~= nil then
            return require(spec.name)(spec.config)
          else
            return require(spec.name)
          end
        end, config.adapter_specs),
      })
    end,
  },
})

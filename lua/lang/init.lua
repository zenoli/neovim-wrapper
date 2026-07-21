local lang_dir = require("nix-info").settings.config_directory .. "/lua/lang/config"

local cache = nil

---@return table<string, LangSpec>
local function load()
  if cache then
    return cache
  end
  cache = {}
  for name, type in vim.fs.dir(lang_dir) do
    if type == "directory" then
      cache[name] = require("lang.config." .. name)
    end
  end
  return cache
end

---@return lze.SpecImport[]
local function specs()
  local result = nixInfo.lze.mod_dir_to_spec("lang.plugins")
  for name, type in vim.fs.dir(lang_dir) do
    if type == "directory" then
      vim.list_extend(result, nixInfo.lze.mod_dir_to_spec("lang.config." .. name .. ".plugins"))
    end
  end
  return result
end

return { load = load, specs = specs }

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

return { load = load }

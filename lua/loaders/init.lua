local lang_dir = require("nix-info").settings.config_directory .. "/lua/lang"

local cache = nil

---@return table<string, table>
local function load()
  if cache then
    return cache
  end
  cache = {}
  for name, _ in vim.fs.dir(lang_dir) do
    local lang = name:match("^(.+)%.lua$") or name
    cache[lang] = require("lang." .. lang)
  end
  return cache
end

return { load = load }

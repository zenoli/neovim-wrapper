---@return string[]
local function get_langs()
  local lang_dir = require("nix-info").settings.config_directory .. "/lua/lang"
  local langs = {}
  for name, type in vim.fs.dir(lang_dir) do
    if type == "directory" then
      if vim.uv.fs_stat(lang_dir .. "/" .. name .. "/test.lua") then
        table.insert(langs, name)
      end
    end
  end
  return langs
end

---@param langs string[]
---@return lze.PluginSpec[]
local function get_neotest_extensions(langs)
  return vim.tbl_map(function(lang)
    return { "neotest-" .. lang, dep_of = "neotest" }
  end, langs)
end

---@param langs string[]
---@return neotest.Adapter[]
local function get_neotest_adapters(langs)
  return vim.tbl_map(function(lang)
    local module = "lang" .. "." .. lang .. ".test"
    return require(module)(lang)
  end, langs)
end

local test_langs = get_langs()

---@type lze.PluginSpec[]
return vim.list_extend(get_neotest_extensions(test_langs), {
  {
    "neotest",
    keys = require("plugins.neotest.keymaps"),
    after = function()
      require("neotest").setup({
        adapters = get_neotest_adapters(test_langs),
      })
    end,
  },
})

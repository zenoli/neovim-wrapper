local get_langs = function(lang_dir)
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

local lang_dir = require("nix-info").settings.config_directory .. "/lua/lang"
local test_langs = get_langs(lang_dir)
vim.print(test_langs)

local adapter_modules = vim.tbl_map(function(lang)
  return "lang" .. "." .. lang .. ".test"
end, test_langs)
vim.print(adapter_modules)

local get_neotest_extensions = function()
  return vim.tbl_map(function(lang)
    return { "neotest-" .. lang, dep_of = "neotest" }
  end, test_langs)
end

return vim.list_extend(get_neotest_extensions(), {
  {
    "neotest",
    keys = require("plugins.neotest.keymaps"),
    after = function()
      require("neotest").setup({
        adapters = vim.tbl_map(function(lang)
          return require("lang" .. "." .. lang .. ".test")(lang)
        end, test_langs),
      })
    end,
  },
})

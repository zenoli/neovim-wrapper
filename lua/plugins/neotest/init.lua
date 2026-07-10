local get_neotest_extensions = function()
  local extensions = {}
  local lang_dir = vim.fn.stdpath("config") .. "/lua/lang"
  for name, type in vim.fs.dir(lang_dir) do
    if type == "directory" then
      if vim.uv.fs_stat(lang_dir .. "/" .. name .. "/test.lua") then
        table.insert(extensions, { "neotest-" .. name, dep_of = "neotest" })
      end
    end
  end
  return extensions
end

return vim.list_extend(get_neotest_extensions(), {
  {
    "neotest",
    keys = require("plugins.neotest.keymaps"),
    after = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
        },
      })
    end,
  },
})

local neotest_langs = require("loaders.neotest")
local config = neotest_langs.get_config()

---@type lze.PluginSpec[]
return vim.list_extend(config.extensions, {
  {
    "neotest",
    keys = require("plugins.neotest.keymaps"),
    after = function()
      require("neotest").setup({
        adapters = neotest_langs.get_adapters(config.adapter_specs),
      })
    end,
  },
})

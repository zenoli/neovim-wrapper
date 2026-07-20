local test_langs = require("lang.plugins.neotest.loader")
local config = test_langs.get_config()

---@type lze.PluginSpec[]
return vim.list_extend(config.extensions, {
  {
    "neotest",
    keys = require("lang.plugins.neotest.keymaps"),
    after = function()
      require("neotest").setup({
        adapters = test_langs.get_adapters(config.adapter_specs),
      })
    end,
  },
})

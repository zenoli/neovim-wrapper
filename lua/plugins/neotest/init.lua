return {
  { "neotest-python", dep_of = "neotest" },
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
}

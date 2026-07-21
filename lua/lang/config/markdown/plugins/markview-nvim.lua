---@type lze.PluginSpec
return {
  "markview.nvim",
  lazy = false,
  after = function(_)
    require("markview").setup({
      preview = {
        linewise_hybrid_mode = false,
        hybrid_modes = { "n" },
      },
    })
  end,
}

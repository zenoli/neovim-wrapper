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
      markdown = {
        list_items = {
          shift_width = 2,
        },
      },
    })
  end,
}

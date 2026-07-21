---@type lze.PluginSpec
return {
  "markview.nvim",
  lazy = false,
  after = function(_)
    require("markview").setup({
      preview = {
        linewise_hybrid_mode = false,
        hybrid_modes = { "n" },
        -- default is at 125. This makes the hybrid_mode unconceal feel snappier
        -- increase if we feel a significant performance impact
        debounce = 10,
      },
      markdown = {
        list_items = {
          shift_width = 2,
        },
      },
    })
  end,
}

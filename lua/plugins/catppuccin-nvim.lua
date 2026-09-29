---@type lze.PluginSpec
return {
  "catppuccin-nvim",
  priority = 1000,
  enabled = true,
  colorscheme = { "catppuccin" },
  after = function()
    -- let the terminal's (semi-transparent, blurred) background show through
    require("catppuccin").setup({ transparent_background = true })
  end,
}

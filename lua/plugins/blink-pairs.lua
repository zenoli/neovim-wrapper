---@type lze.PluginSpec
return {
  "blink.pairs",
  lazy = false,
  after = function()
    require("blink.pairs").setup({})
  end,
}

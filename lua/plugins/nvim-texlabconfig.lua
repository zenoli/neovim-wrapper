---@type lze.PluginSpec
return {
  "nvim-texlabconfig",
  lazy = false,
  after = function()
    require("texlabconfig").setup({})
  end,
}

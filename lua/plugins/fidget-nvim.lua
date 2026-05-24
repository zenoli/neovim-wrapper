return {
  "fidget.nvim",
  event = "DeferredUIEnter",
  after = function(plugin)
    require('fidget').setup({})
  end,
}

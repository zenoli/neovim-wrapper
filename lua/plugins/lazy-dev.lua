---@type lze.PluginSpec
return {
  -- lazydev makes your lua lsp load only the relevant definitions for a file.
  -- It also gives us a nice way to correlate globals we create with files.
  "lazydev.nvim",
  cmd = { "LazyDev" },
  ft = "lua",
  after = function(_)
    require("lazydev").setup({
      library = {
        { words = { "nixInfo%.lze", "lze" }, path = nixInfo("lze", "plugins", "start", "lze") .. "/lua" },
        { words = { "nixInfo%.lze" }, path = nixInfo("lzextras", "plugins", "start", "lzextras") .. "/lua" },
      },
    })
  end,
}

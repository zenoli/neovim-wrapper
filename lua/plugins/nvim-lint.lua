return {
  "nvim-lint",
  -- cmd = { "" },
  event = "FileType",
  -- ft = "",
  -- keys = "",
  -- colorscheme = "",
  after = function(plugin)
    require("lint").linters_by_ft = require("loaders.lint").get_linters_by_ft()

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

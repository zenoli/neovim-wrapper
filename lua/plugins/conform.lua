return {
  "conform.nvim",
  keys = {
    { "<leader>F", desc = "[F]ormat [F]ile" },
  },
  after = function(plugin)
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- NOTE: download some formatters
        -- and configure them here
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
        -- go = { "gofmt", "golint" },
        -- templ = { "templ" },
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        -- javascript = { { "prettierd", "prettier" } },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>F", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "[F]ormat [F]ile" })
  end,
}

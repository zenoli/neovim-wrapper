return {
  {
    "<leader>tn",
    function()
      require("neotest").run.run()
    end,
    desc = "Run nearest test",
  },
  {
    "<leader>td",
    function()
      require("neotest").run.run({ strategy = "dap" })
    end,
    desc = "Debug nearest test",
  },
  {
    "<leader>tl",
    function()
      require("neotest").run.run_last()
    end,
    desc = "Run last test",
  },
  {
    "<leader>tf",
    function()
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    desc = "Run all tests in current file",
  },
  {
    "<leader>ta",
    function()
      require("neotest").run.run(vim.loop.cwd())
    end,
    desc = "Run all tests in current project",
  },
  {
    "<leader>tq",
    function()
      require("neotest").run.stop()
    end,
    desc = "Stop nearest test",
  },
  {
    "<leader>ts",
    function()
      require("neotest").summary.toggle()
    end,
    desc = "Toggle Neotest summary",
  },
}

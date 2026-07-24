---@type lze.PluginSpec
return {
  "fff.nvim",
  lazy = false, -- the plugin lazy-initialises itself
  enabled = false,
  keys = {
    {
      "ff",
      function()
        require("fff").find_files()
      end,
      desc = "FFFind files",
    },
    {
      "fg",
      function()
        require("fff").live_grep()
      end,
      desc = "LiFFFe grep",
    },
    {
      "fz",
      function()
        require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
      end,
      desc = "Live fffuzy grep",
    },
    {
      "fw",
      function()
        require("fff").live_grep_under_cursor()
      end,
      mode = { "n", "x" },
      desc = "Search current word / selection",
    },
  },
}

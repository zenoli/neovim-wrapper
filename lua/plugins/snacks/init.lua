local cursor_relative_input = true

---@type lze.PluginSpec
return {
  "snacks.nvim",
  lazy = false,
  priority = 1000,
  after = function(plugin)
    require("snacks").setup({
      picker = {
        sources = {
          explorer = {
            auto_close = false,
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
          grep = {
            hidden = true,
            ignored = true,
          },
        },
      },
      indent = {
        enabled = true,
        animate = {
          duration = {
            step = 5, -- ms per step
            total = 500, -- maximum duration
          },
        },
      },
      statuscolumn = {
        enabled = false,
        left = { "mark", "git" }, -- priority of signs on the left (high to low)
        right = { "sign", "fold" }, -- priority of signs on the right (high to low)
        folds = {
          open = false, -- show open fold icons
          git_hl = false, -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },
      words = {
        enabled = true,
      },
      bigfile = {
        enabled = true,
      },
      input = {
        enabled = true,
      },
      styles = {
        input = cursor_relative_input and {
          relative = "cursor",
          row = -3,
          col = 0,
        } or nil,
      },
      notifier = {
        enabled = true,
      },
    })
    require("plugins.snacks.keymaps")
  end,
}

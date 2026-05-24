return {
  "snacks.nvim",
  lazy = false,
  priority = 1000,
  after = function(plugin)
    require('snacks').setup({
      picker = {
        sources = {
          explorer = {
            auto_close = false,
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
        enabled = true,
        left = { "mark", "git" },   -- priority of signs on the left (high to low)
        right = { "sign", "fold" }, -- priority of signs on the right (high to low)
        folds = {
          open = false,             -- show open fold icons
          git_hl = false,           -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },
    })
    -- Handle the backend of those remote commands.
    -- hopefully this can be removed one day
    -- NOTE: we aren't loading this lazily, and the keybinds already are so it is fine to just set these here
    require("plugins.snacks.keymaps")
  end
}

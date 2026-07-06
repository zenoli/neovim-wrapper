-- spec for lazy loading colorschemes
return {
  "trigger_colorscheme",
  event = "VimEnter",
  load = function(_name)
    -- schedule so it runs after VimEnter
    vim.schedule(function()
      vim.cmd.colorscheme("catppuccin")
    end)
  end,
}

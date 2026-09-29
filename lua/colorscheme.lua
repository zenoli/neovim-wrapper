-- spec for lazy loading colorschemes
return {
  "trigger_colorscheme",
  -- no trigger: load synchronously during init so the first frame is already
  -- themed (deferring to VimEnter flashes the default theme's solid background)
  load = function(_name)
    vim.cmd.colorscheme("catppuccin")
  end,
}

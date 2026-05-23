local options = {
  cursorline = true,
  showmode = false,

  number = true,
  relativenumber = true,

  splitbelow = true,
  splitright = true,

  laststatus = 3,
  selectmode = "mouse",


  termguicolors = true,

  -- Indentation
  autoindent = true,
  smartindent = true,
  smarttab = true,

  -- tab settings using hard tabs
  tabstop = 4,
  shiftwidth = 4,
  expandtab = true,

  -- Searching
  ignorecase = true,
  smartcase = true,

  -- Scrolling
  scrolloff = 5,
  sidescrolloff = 10,

  -- Listchars
  list = true,
  listchars = {
    tab = "▷▷",
    extends = "󰁔",
    precedes = "󰁍",
  },
  wrap = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

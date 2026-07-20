local map = vim.keymap.set

map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all windows" })
map("n", "<leader>w", "<cmd>update<cr>", { desc = "Write current buffer" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Write all buffers" })

map("n", "<leader>s<leader>", ":% s/", { desc = "Substitute all" })
map("v", "<leader>s<leader>", ": s/", { desc = "Substitute visual selection" })
map("n", "<leader><esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>R", "<cmd>restart<cr>", { desc = "Restart neovim" })

-- scrolling
map("n", "<c-j>", "5<c-e>", { desc = "Scroll down" })
map("n", "<c-k>", "5<c-y>", { desc = "Scroll up" })
map("n", "<c-l>", "5zl", { desc = "Scroll down" })
map("n", "<c-h>", "5zh", { desc = "Scroll up" })

-- Don't move on *
map("n", "*", ":let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>")

-- Jump to beginning and end of lines easier.
map("n", "H", "^")
map("n", "L", "$")

-- Move selected lines vertically
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selected lines up" })

-- Move selected lines horizontally
map("v", ">", ">gv", { desc = "Indent selected lines" })
map("v", "<", "<gv", { desc = "Unindent selected lines" })

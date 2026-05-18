local map = vim.keymap.set

map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all windows" })
map("n", "<leader>w", "<cmd>update<cr>", { desc = "Write current buffer" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Write all buffers" })
map("n", "<leader>s<leader>", ":% s/", { desc = "Substitute all" })
map("v", "<leader>s<leader>", ": s/", { desc = "Substitute visual selection" })
map("n", "<leader><esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>R", "<cmd>restart<cr>", { desc = "Restart neovim" })

map("n", "<A-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<A-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<A-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<A-l>", "<C-w>l", { desc = "Move to right window" })

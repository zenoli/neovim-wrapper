local map = vim.keymap.set
map("n", "<leader>e", Snacks.explorer.open, { desc = 'Snacks file explorer' })
map("n", "<c-\\>", Snacks.terminal.open, { desc = 'Snacks Terminal' })
map("n", "<leader>_", Snacks.lazygit.open, { desc = 'Snacks LazyGit' })
map('n', "<leader>sf", Snacks.picker.smart, { desc = "Smart Find Files" })
map('n', "<leader><leader>s", Snacks.picker.buffers, { desc = "Search Buffers" })
-- find
map('n', "<leader>f", Snacks.picker.files, { desc = "Find Files" })
map('n', "<leader>sg", Snacks.picker.git_files, { desc = "Find Git Files" })
-- Grep
map('n', "<leader>sl", Snacks.picker.lines, { desc = "Buffer Lines" })
map('n', "<leader>sb", Snacks.picker.grep_buffers, { desc = "Grep Open Buffers" })
map('n', "<leader>a", Snacks.picker.grep, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", Snacks.picker.grep_word, { desc = "Visual selection or ord" })
-- search
map('n', "<leader>sd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
map('n', "<leader>sD", Snacks.picker.diagnostics_buffer, { desc = "Buffer Diagnostics" })
map('n', "<leader>sh", Snacks.picker.help, { desc = "Help Pages" })
map('n', "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
map('n', "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
map('n', "<leader>sl", Snacks.picker.loclist, { desc = "Location List" })
map('n', "<leader>sm", Snacks.picker.marks, { desc = "Marks" })
map('n', "<leader>sM", Snacks.picker.man, { desc = "Man Pages" })
map('n', "<leader>sR", Snacks.picker.resume, { desc = "Resume" })
map('n', "<leader>su", Snacks.picker.undo, { desc = "Undo History" })
map('n', "<leader>sn", Snacks.notifier.show_history, { desc = "show notification history" })

map("n", "gb", Snacks.gitbrowse.open, { desc = "Git Browse" })

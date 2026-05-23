return {
  "vim-fugitive",
  cmd = { "Git", "GBrowse" },
  keys = {
    { "<leader>gg",        "<cmd>Git<cr>",                             desc = "Launch fugitive" },
    { "<leader>gp",        ":Git push<cr>",                        desc = "git push" },
    { "<leader>gt",        ":Git log --graph --oneline --all<cr>", desc = "git log" },
    { "<leader>gc",        ":Git checkout<space>",                 desc = "Git checkout" },
    { "<leader>gb",        ":Git branch<space>",                   desc = "Git branch" },
    { "<leader>g<leader>", ":Git ",                                desc = "Git prompt" },
    { "<leader>gh",        ":diffget //2<cr> ",                    desc = "Git get left" },
    { "<leader>gl",        ":diffget //3<cr> ",                    desc = "Git get right" },
  },
}

---@type lze.PluginSpec[]
return {
  {
    "nvim.undotree",
    cmd = {
      "Undotree",
    },
    keys = {
      {
        "<leader>U",
        "<cmd>Undotree<cr>",
        mode = { "n" },
        desc = "Undo Tree"
      },
    },
  },
}

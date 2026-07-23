local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", {}, opts or {})
  opts.desc = "LSP: " .. opts.desc
  Snacks.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", lsp = { method = "textDocument/rename" } })
map(
  "n",
  "<leader>ca",
  vim.lsp.buf.code_action,
  { desc = "[C]ode [A]ction", lsp = { method = "textDocument/codeAction" } }
)
map(
  "n",
  "gd",
  Snacks.picker.lsp_definitions,
  { desc = "[G]oto [D]efinition", lsp = { method = "textDocument/definition" } }
)
map(
  "n",
  "<leader>D",
  vim.lsp.buf.type_definition,
  { desc = "Type [D]efinition", lsp = { method = "textDocument/typeDefinition" } }
)
map(
  "n",
  "gr",
  Snacks.picker.lsp_references,
  { desc = "[G]oto [R]eferences", lsp = { method = "textDocument/references" } }
)
map(
  "n",
  "gI",
  Snacks.picker.lsp_implementations,
  { desc = "[G]oto [I]mplementation", lsp = { method = "textDocument/implementation" } }
)
map(
  "n",
  "<leader>ds",
  Snacks.picker.lsp_symbols,
  { desc = "[D]ocument [S]ymbols", lsp = { method = "textDocument/documentSymbol" } }
)

-- See `:help K` for why this keymap
map(
  "n",
  "gh",
  vim.lsp.buf.signature_help,
  { desc = "Signature Documentation", lsp = { method = "textDocument/signatureHelp" } }
)

map("n", "<leader>ih", function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end, { desc = "Toggle [I]nlay [H]ints", lsp = { method = "textDocument/inlayHint" } })
-- Lesser used LSP functionality
map(
  "n",
  "gD",
  vim.lsp.buf.declaration,
  { desc = "[G]oto [D]eclaration", lsp = { method = "textDocument/declaration" } }
)

-- Diagnostics are not tied to a specific LSP method, so these apply globally
map("n", "<leader>ld", function()
  vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Show line diagnostics" })
map("n", "<leader>cd", function()
  vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Show cursor diagnostics" })

-- Overwrite the default keybindings as they are not showing the floating window
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous [D]iagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next [D]iagnostic" })

return {
  disable_global_defaults = function()
    for _, key in ipairs({ "gra", "gri", "grn", "grr", "grt", "grx" }) do
      vim.keymap.del("n", key)
    end
  end,
}

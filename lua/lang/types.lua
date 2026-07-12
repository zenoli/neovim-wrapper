---@class LangSpec
---@field lsp? table<string, vim.lsp.ClientConfig> LSP servers keyed by server name. Each value is passed to vim.lsp.config().
---@field test? true | LangTestSpec | LangTestSpec[] Neotest adapter(s). `true` uses "neotest-{lang}" with no config.
---@field format? string[] | table<string, string[]> Formatters for conform.nvim. List uses lang as filetype; table keys are explicit filetypes.
---@field lint? string[] | table<string, string[]> Linters for nvim-lint. List uses lang as filetype; table keys are explicit filetypes.

---@class LangTestSpec
---@field name? string Adapter plugin name. Defaults to "neotest-{lang}".
---@field config? table Passed as argument to the adapter on require.

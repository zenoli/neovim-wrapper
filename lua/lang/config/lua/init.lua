---@type LangSpec
return {
  lsp = {
    lua_ls = {
      filetypes = { "lua" },
      settings = {
        Lua = {
          signatureHelp = { enabled = true },
          diagnostics = {
            globals = { "nixInfo", "vim", "Snacks" },
            disable = { "missing-fields" },
          },
        },
      },
    },
  },
  format = { "stylua" },
}

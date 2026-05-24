return {
  -- name of the lsp
  "lua_ls",
  lsp = {
    filetypes = { 'lua' },
    settings = {
      Lua = {
        signatureHelp = { enabled = true },
        diagnostics = {
          globals = { "nixInfo", "vim", "Snacks" },
          disable = { 'missing-fields' },
        },
      },
    },
  },
  -- also these are regular specs and you can use before and after and all the other normal fields
}

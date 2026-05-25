return {
  filetypes = { 'lua' },
  settings = {
    Lua = {
      signatureHelp = { enabled = true },
      diagnostics = {
        globals = { "nixInfo", "vim", "Snacks", "blubb" },
        disable = { 'missing-fields' },
      },
    },
  },
}

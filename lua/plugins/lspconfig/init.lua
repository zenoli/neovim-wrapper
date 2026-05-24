return {
  "nvim-lspconfig",
  lsp = function(plugin)
    vim.lsp.config(plugin.name, plugin.lsp or {})
    vim.lsp.enable(plugin.name)
  end,
  before = function(_)
    local signs = { Error = " ", Warn = " ", Hint = "󰋗 ", Info = " " }
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.HINT] = signs.Hint,
          [vim.diagnostic.severity.INFO] = signs.Info,
        },
      },
    })
    vim.lsp.config('*', {
      on_attach = function(_, bufnr)
        -- we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end
        require("plugins.lspconfig.keymaps").load(nmap)

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end
    })
  end,
}

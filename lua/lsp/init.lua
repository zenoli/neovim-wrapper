-- require("lsp.keymaps").disable_defaults()

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰋗 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local nmap = function(keys, func, desc, opts)
      if desc then desc = 'LSP: ' .. desc end
      vim.keymap.set(
        'n',
        keys,
        func,
        vim.tbl_extend('force', { buf = bufnr, desc = desc }, opts or {}))
    end
    require("lsp.keymaps").disable_defaults2(bufnr)
    require("lsp.keymaps").load(nmap)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end,
})

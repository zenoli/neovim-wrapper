local get_lsp_mapping_fn = function(bufnr)
  return function(keys, func, desc, opts)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set(
      'n',
      keys,
      func,
      vim.tbl_extend('force', { buf = bufnr, desc = desc }, opts or {}))
  end
end

return {
  disable_global_defaults = function()
    for _, key in ipairs({ 'gra', 'gri', 'grn', 'grr', 'grt', 'grx' }) do
      vim.keymap.del('n', key)
    end
  end,

  load = function(bufnr)
    local nmap = get_lsp_mapping_fn(bufnr)

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('gr', Snacks.picker.lsp_references, '[G]oto [R]eferences')
    nmap('gI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>ds', Snacks.picker.lsp_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>F', vim.lsp.buf.format, 'Format document')

    -- See `:help K` for why this keymap
    nmap('gh', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap("<leader>ld", function() vim.diagnostic.open_float { scope = "line" } end, "Show line diagnostics")
    nmap("<leader>cd", function() vim.diagnostic.open_float { scope = "cursor" } end, "Show cursor diagnostics")


    -- Overwrite the default keybindings as they are not showing the floating window
    nmap('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Previous [D]iagnostic')
    nmap(']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next [D]iagnostic')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end
}

return {
  load = function(nmap)
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
    nmap('gI', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')
    nmap('<leader>ds', function() Snacks.picker.lsp_symbols() end, '[D]ocument [S]ymbols')
    nmap('<leader>F', vim.lsp.buf.format, 'Format document')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap("<leader>ld", function() vim.diagnostic.open_float { scope = "line" } end, "Show line diagnostics")
    nmap("<leader>cd", function() vim.diagnostic.open_float { scope = "cursor" } end, "Show cursor diagnostics")

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end
}

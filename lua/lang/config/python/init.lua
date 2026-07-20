---@type LangSpec
return {
  test = true,
  lsp = {
    basedpyright = {
      filetypes = { "python" },
      settings = {},
    },
  },
  lint = { "ruff" },
  format = {
    "ruff_fix",
    "ruff_organize_imports",
    "ruff_format",
  },
}

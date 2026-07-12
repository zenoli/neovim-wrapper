---@type LangSpec
return {
  lsp = {
    texlab = {
      settings = {
        texlab = {
          auxDirectory = ".",
          bibtexFormatter = "texlab",
          build = {
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
            executable = "latexmk",
            forwardSearchAfter = true,
            onSave = true,
          },
          chktex = {
            onEdit = false,
            onOpenAndSave = false,
          },
          diagnosticsDelay = 300,
          formatterLineLength = 80,
          forwardSearch = {
            executable = "zathura",
            args = {
              "--synctex-editor-command",
              require("texlabconfig").project_dir()
                .. [[/nvim-texlabconfig -file '%%%{input}' -line %%%{line} -server ]]
                .. vim.v.servername,
              "--synctex-forward",
              "%l:1:%f",
              "%p",
            },
          },
          latexFormatter = "latexindent",
          latexindent = {
            modifyLineBreaks = true,
            ["local"] = ".latexindent.yaml",
          },
        },
      },
    },
  },
}

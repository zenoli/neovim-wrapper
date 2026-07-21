---@type LangSpec
return {
  test = {
    config = {
      -- Prefer project-local python (venv/poetry/uv/etc, via neotest-python's own
      -- detection); fall back to nvim's bundled python3 host, which also has pytest
      -- (see hosts.python3.withPackages in default.nix), for projects with none of those.
      python = function(root)
        local cmd = require("neotest-python.base").get_python_command(root)
        if cmd[1] and vim.fn.executable(cmd[1]) == 1 then
          return cmd
        end
        return { vim.g.python3_host_prog or "python3" }
      end,
    },
  },
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

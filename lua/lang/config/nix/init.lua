-- devenv.nix alone is not a reliable marker: plain nix repos may contain
-- modules that happen to be named devenv.nix.
local DEVENV_MARKERS = { "devenv.yaml", "devenv.lock" }
local NIXD_MARKERS = { "flake.nix", ".git" }

-- Makes nixd and devenv mutually exclusive per buffer: devenv projects (any
-- ancestor with a devenv.yaml/devenv.lock) get `devenv lsp`; everything else
-- gets plain nixd.
---@param name "nixd" | "devenv"
---@return fun(bufnr: integer, on_dir: fun(root_dir: string))
local function get_root_dir(name)
  return function(bufnr, on_dir)
    local devenv_root = vim.fs.root(bufnr, DEVENV_MARKERS)
    if name == "devenv" then
      if devenv_root then
        on_dir(devenv_root)
      end
    else
      if not devenv_root then
        on_dir(vim.fs.root(bufnr, NIXD_MARKERS) or vim.fn.getcwd())
      end
    end
  end
end

---@type LangSpec
return {
  lsp = {
    nixd = {
      filetypes = { "nix" },
      root_dir = get_root_dir("nixd"),
      settings = {
        nixd = {
          nixpkgs = {
            expr = [[import <nixpkgs> {}]],
          },
          options = {},
          formatting = {
            command = { "nixfmt" },
          },
          diagnostic = {
            suppress = {
              "sema-escaping-with",
            },
          },
        },
      },
    },
    devenv = {
      filetypes = { "nix" },
      -- `devenv lsp` resolves devenv.nix from its cwd, which defaults to
      -- nvim's cwd rather than root_dir.
      cmd = function(dispatchers, config)
        return vim.lsp.rpc.start(
          { "devenv", "lsp" },
          dispatchers,
          { cwd = config.root_dir }
        )
      end,
      root_dir = get_root_dir("devenv"),
      on_init = function(client)
        local result = vim
          .system(
            { "devenv", "lsp", "--print-config" },
            { cwd = client.config.root_dir, text = true }
          )
          :wait()
        if result.code ~= 0 then
          vim.notify(
            "devenv lsp --print-config failed: " .. (result.stderr or ""),
            vim.log.levels.WARN
          )
          return
        end
        local ok, settings = pcall(vim.json.decode, result.stdout)
        if ok then
          client.settings = settings
          client:notify("workspace/didChangeConfiguration", { settings = settings })
        end
      end,
    },
  },
}

vim.loader.enable() -- <- bytecode caching
do
  -- Set up a global in a way that also handles non-nix compat
  _G.nixInfo = require(vim.g.nix_info_plugin_name)
  ---@module 'lzextras'
  ---@type lzextras | lze
  nixInfo.lze = setmetatable(require("lze"), getmetatable(require("lzextras")))
  function nixInfo.get_nix_plugin_path(name)
    return nixInfo(nil, "plugins", "lazy", name) or nixInfo(nil, "plugins", "start", name)
  end
end

nixInfo.lze.register_handlers({ nixInfo.lze.lsp })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local import = nixInfo.lze.mod_dir_to_spec

nixInfo.lze.load({
  require("colorscheme"),
  import("plugins"),
  import("lsp.servers"),
})

require("keymaps")
require("options")
require("lsp")

require("vim._core.ui2").enable({ enable = true })

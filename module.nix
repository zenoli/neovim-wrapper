inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  langConfigDir = ./lua/lang/config;
  langModules = lib.pipe (builtins.readDir langConfigDir) [
    (lib.filterAttrs (_: type: type == "directory"))
    (lib.mapAttrsToList (
      name: _: lib.modules.importApply (langConfigDir + "/${name}/default.nix") inputs
    ))
  ];
in
{
  imports = [ wlib.wrapperModules.neovim ] ++ langModules;

  options.nvim-lib.neovimPlugins = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf wlib.types.stringable;
    default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
  };

  # config.settings.config_directory = ./.;
  config.settings.config_directory = "/home/olivier/repos/neovim";
  config.specs.lze = {
    after = [ ];
    data = with config.nvim-lib.neovimPlugins; [
      lze
      lzextras
    ];
  };

  config.specs.general = {
    after = [ "lze" ];
    runtimePkgs = with pkgs; [
      lazygit
      tree-sitter
    ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      {
        data = snacks-nvim;
        runtimePkgs = with pkgs; [
          fd
          ripgrep
        ];
      }
      blink-cmp
      blink-compat
      blink-pairs
      catppuccin-nvim
      papercolor-theme
      cmp-cmdline
      colorful-menu-nvim
      conform-nvim
      dropbar-nvim
      fidget-nvim
      gitsigns-nvim
      lualine-nvim
      neotest
      nvim-lint
      nvim-lspconfig
      nvim-surround
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      vim-fugitive
      vim-startuptime
      vim-tmux-navigator
      which-key-nvim
    ];
  };

  config.specMods =
    {
      parentSpec ? null,
      parentOpts ? null,
      parentName ? null,
      config,
      ...
    }:
    {
      options.runtimePkgs = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [ ];
        description = "a runtimePkgs spec field to put packages to suffix to the PATH";
      };
      config.after = lib.mkIf (parentSpec == null) (lib.mkDefault [ "general" ]);
    };
  config.runtimePkgs = config.specCollect (acc: v: acc ++ (v.runtimePkgs or [ ])) [ ];

  options.nvim-lib.pluginsFromPrefix = lib.mkOption {
    type = lib.types.raw;
    readOnly = true;
    default =
      prefix: inputs:
      lib.pipe inputs [
        builtins.attrNames
        (builtins.filter (s: lib.hasPrefix prefix s))
        (map (
          input:
          let
            name = lib.removePrefix prefix input;
          in
          {
            inherit name;
            value = config.nvim-lib.mkPlugin name inputs.${input};
          }
        ))
        builtins.listToAttrs
      ];
  };
}

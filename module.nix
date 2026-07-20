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
    # this would ensure any config included from nix in here will be ran after any provided by the `lze` spec
    # If we provided any from within either spec, anyway
    after = [ "lze" ];
    # note we didn't have to specify the `lze` specs name, because it was a top level spec
    extraPackages = with pkgs; [
      lazygit
      tree-sitter
    ];
    # this `lazy = true` definition will transfer to specs in the contained DAL, if there is one.
    # This is because the definition of lazy in `config.specMods` checks `parentSpec.lazy or false`
    # the submodule type for `config.specMods` gets `parentSpec` as a `specialArg`.
    # you can define options like this too!
    lazy = true;
    # here we chose a DAL of plugins, but we can also pass a single plugin, or null
    # plugins are of type wlib.types.stringable
    data = with pkgs.vimPlugins; [
      {
        data = snacks-nvim;
        extraPackages = with pkgs; [
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
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [ ];
        description = "a extraPackages spec field to put packages to suffix to the PATH";
      };
      config.after = lib.mkIf (parentSpec == null) (lib.mkDefault [ "general" ]);
    };
  config.extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [ ])) [ ];

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

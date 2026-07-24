{ pkgs, ... }:
{
  config.specs.general = {
    after = [ "lze" ];
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
      fff-nvim
      vim-fugitive
      vim-startuptime
      vim-tmux-navigator
      which-key-nvim
    ];
  };
}

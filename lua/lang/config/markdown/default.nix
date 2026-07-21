inputs:
{ pkgs, lib, ... }:
{
  config.specs.markdown = {
    lazy = false;
    data = with pkgs.vimPlugins; [
      markview-nvim
    ];
    runtimePkgs = with pkgs; [
      marksman
      prettier
      prettierd
    ];
  };
}

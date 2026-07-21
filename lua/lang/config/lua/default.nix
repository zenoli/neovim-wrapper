inputs:
{ pkgs, lib, ... }:
{
  config.specs.lua = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      lazydev-nvim
    ];
    runtimePkgs = with pkgs; [
      lua-language-server
      stylua
    ];
  };
}

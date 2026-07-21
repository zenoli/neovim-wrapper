inputs:
{ pkgs, lib, ... }:
{
  config.specs.python = {
    lazy = true;
    data = with pkgs.vimPlugins; [ neotest-python ];
    runtimePkgs = with pkgs; [
      basedpyright
      ruff
    ];
  };
}

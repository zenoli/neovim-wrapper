_inputs:
{ pkgs, lib, ... }:
{
  config.specs.python = {
    lazy = true;
    data = with pkgs.vimPlugins; [ neotest-python ];
    extraPackages = with pkgs; [
      basedpyright
      ruff
    ];
  };
}

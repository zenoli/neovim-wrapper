inputs:
{ pkgs, lib, ... }:
{
  config.specs.python = {
    lazy = true;
    data = with pkgs.vimPlugins; [ neotest-python ];
    runtimePkgs = with pkgs; [
      basedpyright
      ruff
      python3Packages.pytest
    ];
  };
  config.hosts.python3.withPackages = pp: [ pp.pytest ];
}

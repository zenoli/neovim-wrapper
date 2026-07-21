inputs:
{ pkgs, lib, ... }:
{
  config.specs.nix = {
    data = null;
    runtimePkgs = with pkgs; [
      nixd
      nixfmt
    ];
  };
}

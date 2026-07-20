{ pkgs, lib, ... }:
{
  config.specs.nix = {
    data = null;
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
  };
}

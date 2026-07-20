inputs:
{ pkgs, lib, ... }:
{
  config.specs.latex = {
    lazy = true;
    data = [
      {
        data = pkgs.callPackage ./pkgs/nvim-texlabconfig.nix { src = inputs.nvim-texlabconfig; };
        lazy = false;
      }
    ];
    extraPackages = with pkgs; [
      texlab
      (texliveSmall.withPackages (ps: [
        ps.latexmk
        ps.latexindent
      ]))
    ];
  };
}

{ pkgs, lib, ... }:
{
  config.specs.latex = {
    lazy = true;
    data = [
      {
        data = pkgs.nvim-texlabconfig;
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

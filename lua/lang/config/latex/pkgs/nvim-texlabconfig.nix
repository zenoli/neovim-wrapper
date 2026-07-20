{
  pkgs,
  lib,
  src,
}:
let
  goBin = pkgs.buildGoModule {
    pname = "nvim-texlabconfig";
    version = toString (src.lastModifiedDate or "master");
    inherit src;
    vendorHash = "sha256-rGkR6J18wv3z5rncOQhI6kHWP/j9zMKlHk+rmwYKoi8=";
  };
in
pkgs.vimUtils.buildVimPlugin {
  pname = "nvim-texlabconfig";
  version = toString (src.lastModifiedDate or "master");
  inherit src;
  doCheck = false;
  postInstall = ''
    cp ${goBin}/bin/nvim-texlabconfig $out/
  '';
}

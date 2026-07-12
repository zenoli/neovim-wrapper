{
  description = "LaTeX demo project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          (pkgs.texliveSmall.withPackages (ps: [
            ps.latexmk
            ps.latexindent
          ]))
          pkgs.texlab
        ];
      };
    };
}

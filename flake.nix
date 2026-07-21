{
  description = "Flake exporting a configured neovim package";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  inputs.wrappers.inputs.nixpkgs.follows = "nixpkgs";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  inputs.plugins-lze = {
    url = "github:BirdeeHub/lze";
    flake = false;
  };
  inputs.plugins-lzextras = {
    url = "github:BirdeeHub/lzextras";
    flake = false;
  };
  inputs.nvim-texlabconfig = {
    url = "github:f3fora/nvim-texlabconfig";
    flake = false;
  };
  outputs =
    {
      self,
      nixpkgs,
      wrappers,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.platforms.all;
      imports = [ wrappers.flakeModules.wrappers ];

      flake.wrappers.neovim = nixpkgs.lib.modules.importApply ./nix/wrapper inputs;

      flake.nixosModules =
        (builtins.mapAttrs (_: v: v.install) self.wrappers)
        // { default = self.nixosModules.neovim; };
      flake.homeModules = self.nixosModules;

      perSystem =
        { system, config, ... }:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          packages.default = config.packages.neovim;
          devShells.default = import ./nix/shell.nix { inherit pkgs; };
        };
    };
}

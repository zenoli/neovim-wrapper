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
  inputs.git-hooks.url = "github:cachix/git-hooks.nix";
  inputs.git-hooks.inputs.nixpkgs.follows = "nixpkgs";
  outputs =
    {
      self,
      nixpkgs,
      wrappers,
      flake-parts,
      git-hooks,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.platforms.all;
      imports = [
        wrappers.flakeModules.wrappers
        git-hooks.flakeModule
      ];

      flake.wrappers =
        let
          neovim = nixpkgs.lib.modules.importApply ./nix/wrapper inputs;
        in
        {
          inherit neovim;
          neovim-dev = {
            imports = [ neovim ];
            devDir = "/home/olivier/repos/neovim";
          };
        };

      flake.nixosModules = (builtins.mapAttrs (_: v: v.install) self.wrappers) // {
        default = self.nixosModules.neovim;
      };
      # flake.homeModules = self.nixosModules;
      flake.homeModules = (builtins.mapAttrs (_: v: v.install) self.wrappers);

      perSystem =
        { system, config, ... }:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          packages.default = config.packages.neovim;
          pre-commit.pkgs = pkgs;
          pre-commit.settings.hooks = {
            stylua = {
              enable = true;
            };
            nixfmt = {
              enable = true;
            };
          };
          devShells.default = import ./nix/shell.nix {
            inherit pkgs;
            shellHook = config.pre-commit.shellHook;
            extraPackages = config.pre-commit.settings.enabledPackages;
          };
        };
    };
}

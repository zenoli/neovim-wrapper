{
  pkgs,
  shellHook ? "",
  extraPackages ? [ ],
}:
pkgs.mkShell {
  packages =
    with pkgs;
    [
      lua
      (writeShellScriptBin "dev" ''
        exec nix run "$(git rev-parse --show-toplevel)#neovim-dev" -- "$@"
      '')
      (writeShellScriptBin "run" ''
        exec nix run "$(git rev-parse --show-toplevel)#neovim" -- "$@"
      '')
      (writeShellScriptBin "plugin-name" ''
        if [ -z "$1" ]; then
          echo "Usage: plugin-name <vimPlugin-attr>" >&2
          echo "Example: plugin-name blink-cmp" >&2
          exit 1
        fi
        nix eval nixpkgs#vimPlugins."$1".pname --raw
      '')
    ]
    ++ extraPackages;
  inherit shellHook;
}

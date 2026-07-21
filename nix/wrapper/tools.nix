{ pkgs, ... }:
{
  config.specs.tools = {
    data = null;
    runtimePkgs = with pkgs; [
      lazygit
      tree-sitter
    ];
  };
}

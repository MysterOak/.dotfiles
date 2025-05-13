{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zed-editor
    nil
    nixd
  ];
}

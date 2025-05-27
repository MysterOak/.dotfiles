{ pkgs, ... }:
{
  programs.ghostty.enable = true;

  home.packages = with pkgs; [
    zed-editor
    nil
    nixd
  ];

  home.file.".config/ghostty/config".source = ./ghosttyconfig;

}

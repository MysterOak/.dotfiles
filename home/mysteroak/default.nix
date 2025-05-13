{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ../common
  ];

  home.username = "mysteroak";
  home.homeDirectory = "/home/mysteroak";

  home.packages = with pkgs; [
    fastfetch
  ];


  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

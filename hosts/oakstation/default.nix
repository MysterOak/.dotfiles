{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../common
      ../common/desktop
      ../common/desktop/gnome.nix
      ../common/desktop/steam.nix

      ./disko-config.nix
    ];

  networking.hostName = "oakstation";

  # Install firefox.
  programs.firefox.enable = true;


  system.stateVersion = "24.11";

}

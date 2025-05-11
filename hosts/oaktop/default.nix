{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../common
      ../common/gnome.nix

      ./disko-config.nix
    ];

  networking.hostName = "oaktop";

  system.stateVersion = "24.11";
}

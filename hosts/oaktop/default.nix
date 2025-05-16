{ ... }:
{
  imports =
    [
      ../common
      ../common/desktop
      ../common/desktop/cosmic.nix
      ../common/hw-conf-intel.nix

      ./disko-config.nix
    ];

  networking.hostName = "oaktop";
  networking.hostId = "2d5e7676";

  system.stateVersion = "24.11";
}

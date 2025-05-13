{ lib, ... }:
{
  imports =
    [
      ../common
      ../common/desktop/gnome.nix
      ../common/hw-conf-intel.nix

      ./disko-config.nix
    ];

  networking.hostName = "oaktop";
  networking.hostId = "2d5e7676";

  boot.initrd.postDeviceCommands = lib.mkAfter ''
      zfs rollback -r zroot/local/root@empty
    '';

  system.stateVersion = "24.11";
}

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

  etc."NetworkManager/system-connections" = {
    source = "/persist/etc/NetworkManager/system-connections/";
  };

  systemd.tmpfiles.rules = [
      "L /var/lib/bluetooth - - - - /persist/var/lib/bluetooth"
  ];

  services.openssh.hostKeys = [
    {
      path = "/persist/ssh/oaktop";
      type = "ed25519";
    }
  ];

  system.stateVersion = "24.11";
}

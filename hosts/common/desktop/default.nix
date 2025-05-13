{...}:
{
  imports = [
    ./audio.nix
    ./localsend.nix

  ];

  environment.etc = {
    "NetworkManager/system-connections".source = "/persist/etc/NetworkManager/system-connections/";
  };

  systemd.tmpfiles.rules = [
      "L /var/lib/bluetooth - - - - /persist/var/lib/bluetooth"
  ];

  services.flatpak.enable = true;
}

{...}:
{
  imports = [
    ./audio.nix
    ./localsend.nix

  ];

  boot = {
      plymouth = {
        enable = true;
      };
      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      loader.timeout = 0;
    };

  boot.zfs.allowHibernation = true;

  services.flatpak.enable = true;
}

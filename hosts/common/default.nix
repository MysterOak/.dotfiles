{ pkgs,... }:
{

  imports = [
    ./users
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.supportedFilesystems = ["zfs"];

  boot.kernel.sysctl = { "vm.swappiness" = 10;}; #reduce swappiness from 60 -> 10

  zramSwap = {
    enable = true;
    priority = 5;
  };

  services.zfs.trim = {
    enable = true;
    interval = "weekly";
  };

  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
    randomizedDelaySec = "6h";
  };




  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [git];


  users.mutableUsers = false;

  nixpkgs = {

    config = {
      allowUnfree = true;
    };

  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      cores = 4;
      max-jobs = 8;
      trusted-users = [
        "root"
        "mysteroak"
      ];
    };

    optimise.automatic = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/mysteroak/.dotfiles";
  };

  services.fstrim.enable = true;

  services.openssh = {
	  enable = true;
	  settings.PermitRootLogin = "no";
    settings = {
	    PasswordAuthentication = false;
	  };
	};

}

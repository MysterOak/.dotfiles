{ pkgs,... }:
{

  imports = [
    ./users
    ./global
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = { "vm.swappiness" = 10;}; #reduce swappiness from 60 -> 10
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      allowHibernation = true;
    };
    initrd = {
      network.enable = true;
      systemd = {
        enable = true;
        services.zfs-rollback = {
          description = "Rollback ZFS root dataset to blank snapshot";
          wantedBy = [
            "initrd.target"
          ];
          after = [
            # this is a dynamically generated service, based on the zpool name
            "zfs-import-zroot.service"
          ];
          before = [
            "sysroot.mount"
          ];
          path = with pkgs; [
            zfs
          ];
          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = ''
            zfs rollback -r  zroot/local/root@empty && echo "zfs rollback complete"
          '';
        };
      };
    };
  };

  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';

  zramSwap = {
    enable = true;
    priority = 5;
  };

  services.zfs = {
    trim = {
      enable = true;
      interval = "weekly";
    };
    autoScrub = {
      enable = true;
      interval = "monthly";
      randomizedDelaySec = "6h";
    };
  };

  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/nixos"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };

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

    channel.enable = false;

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

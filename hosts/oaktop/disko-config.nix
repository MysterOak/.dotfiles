let
  rootDisk = "/dev/disk/by-id/nvme-Micron_2200S_NVMe_1024GB__20112700B5DB";
in {
  disko.devices = {

    disk = {

      boot-disk = {
        device = rootDisk;
        type = "disk";
        content = {

          type = "gpt";
          partitions = {

            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };

            };

            swap = {
              size = "24G"; #1.5x RAM
              type = "8200";
              content = {
                type = "swap";
                priority = 0;
                resumeDevice = true;
              };

            };

            root = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };

            };

          };

        };

      };

    };

    zpool = {

      zroot = {

        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          canmount = "off";
          checksum = "edonr";
          compression = "lz4";
          dnodesize = "auto";
          normalization = "formD";
          relatime = "on";
          xattr = "sa";
        };

        mountpoint = null;
        options = {
          ashift = "12";
          autotrim = "on";
        };

        datasets = {

          root = {
            type = "zfs_fs";
            options.canmount = "off";
          };

          "root/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "/";
          };

          "root/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "/nix";
          };

          "root/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options.mountpoint = "/home";
          };

          "root/games" = { #game storage location
            type = "zfs_fs";
            mountpoint = "/games";
            options.mountpoint = "/games";
          };

        };

      };

    };

  };

}

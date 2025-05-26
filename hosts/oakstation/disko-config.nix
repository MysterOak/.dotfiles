let
  disk1 = "/dev/disk/by-id/nvme-CT1000P1SSD8_20222876D1D7";
in {
  disko.devices = {

    disk = {

      disk1 = {
        device = disk1;
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
              size = "48G"; #1.5x RAM
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

          local = {
            type = "zfs_fs";
            options.canmount = "off";
          };

          safe = {
            type = "zfs_fs";
            options.canmount = "off";
          };

          "local/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "/";
            postCreateHook = ''
            zfs snapshot zroot/local/root@empty
            '';
          };

          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "/nix";
          };

          "safe/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options.mountpoint = "/home";
          };

          "safe/persist" = {
            type = "zfs_fs";
            mountpoint = "/persist";
            options.mountpoint = "/persist";
          };

        };

      };

    };

  };

  fileSystems."/persist".neededForBoot = true;

}

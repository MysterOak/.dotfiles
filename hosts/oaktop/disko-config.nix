{
  disko.devices = {

    disk = {

      boot-disk = {
        device = "/dev/disk/by-id/nvme-Micron_2200S_NVMe_1024GB__20112700B5DB";
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
              size = "32G";
              type = "8200";
              content = {
                type = "swap";
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

}

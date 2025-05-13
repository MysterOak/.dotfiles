{
  disko.devices = {
    disk = {


      boot-disk = {
        device = "/dev/";
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

      nvme1 = {
        device = "/dev/";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zfast";
              };
            };
          };
        };
      };

      nvme2 = {
        device = "/dev/";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zfast";
              };
            };
          };
        };
      };

      hdd1 = {
        device = "/dev/";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zslow";
              };
            };
          };
        };
      };

      hdd2 = {
        device = "/dev/";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zslow";
              };
            };
          };
        };
      };

      hdd3 = {
        device = "/dev/";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zslow";
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

      zfast = {
        type = "zpool";
        mode = "mirror";
        mountpoint = null;

        datasets = {

          "config" ={
            type = "zfs_fs";
            mountpoint = "/zfast/config";
          };

          "fastStorage" ={
            type = "zfs_fs";
            mountpoint = "/zfast/storage";
          };

        };

      };

      zslow = {
        type = "zpool";
        mode = "raidz";
        mountpoint = null;

        datasets = {
          "media" = {
            type = "zfs_fs";
            mountpoint = "/zslow/media";
          };
          "media/movies" = {
            type = "zfs_fs";
            mountpoint = "/zslow/media/movies";
          };
          "media/tv" = {
            type = "zfs_fs";
            mountpoint = "/zslow/media/tv";
          };
          "media/music" = {
            type = "zfs_fs";
            mountpoint = "/zslow/media/music";
          };
          "media/books" = {
            type = "zfs_fs";
            mountpoint = "/zslow/media/books";
          };
          "media/audiobooks" = {
            type = "zfs_fs";
            mountpoint = "/zslow/media/audiobooks";
          };
          "media/pictures" = {
            type = "zfs_fs";
            mountpoint = "/zslow/media/pictures";
          };
        };

      };

    };
  };
}

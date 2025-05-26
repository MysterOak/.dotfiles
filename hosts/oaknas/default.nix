{...}:
{
  imports = [
    ../common
    ../common/server
    ../common/hardware/hw-conf-intel.nix

    ./disko-config.nix
  ];

  networking.hostName = "oaknas";
  networking.hostId = "f84cbd69";

  environment.persistence."/persist" = {
    directories = [

    ];
    files = [

    ];
  };

  system.stateVersion = "24.11";
}

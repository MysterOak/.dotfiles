{...}:
{
  imports = [
    ../common
    ../common/server
    ../common/hw-conf-intel.nix

    ./disko-config.nix
  ];

  networking.hostName = "oaknas";
  networking.hostId = "f84cbd69";

  system.stateVersion = "24.11";
}

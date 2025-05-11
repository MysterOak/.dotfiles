{...}:
{
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/server

    ./disko-config.nix
  ];

  networking.hostName = "oaknas";

  system.stateVersion = "24.11";
}

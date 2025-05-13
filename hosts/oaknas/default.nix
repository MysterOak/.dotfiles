{...}:
{
  imports = [
    ../common
    ../common/server
    ../common/hw-conf-vm.nix

    ./disko-config.nix
  ];

  networking.hostName = "oaknas";
  networking.hostId = "f84cbd69";

  system.stateVersion = "24.11";
}

{ ... }:

{
  imports =
    [
      ../common
      ../common/desktop
      ../common/desktop/gnome.nix
      ../common/hw-conf-amd.nix

      ./disko-config.nix
    ];

  networking.hostName = "oakstation";
  networking.hostId = "c2a85637";

  services.xserver.videoDrivers = ["amdgpu"];

  # Install firefox.
  programs.firefox.enable = true;


  system.stateVersion = "24.11";

}

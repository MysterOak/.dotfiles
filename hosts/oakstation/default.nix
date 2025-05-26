{ ... }:

{
  imports =
    [
      ../common
      ../common/desktop
      ../common/desktop/gnome.nix
      ../common/hardware/hw-conf-amd.nix

      ./disko-config.nix
    ];

  networking.hostName = "oakstation";
  networking.hostId = "c2a85637";

  services.xserver.videoDrivers = ["amdgpu"];

  environment.persistence."/persist" = {
    directories = [

    ];
    files = [

    ];
  };

  system.stateVersion = "24.11";

}

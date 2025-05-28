{ inputs, config, lib, ... }:
{
  imports =
    [
      ../common
      ../common/desktop
      ../common/desktop/gnome.nix
      ../common/hardware/hw-conf-intel.nix

      ../common/optional/secureboot.nix
      ../common/optional/localsend.nix

      ./disko-config.nix

      inputs.nixos-hardware.nixosModules.common-pc-laptop
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable
    ];

  networking.hostName = "oaktop";
  networking.hostId = "2d5e7676";

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  console.earlySetup = true;
  services.fwupd.enable = lib.mkDefault true;
  services.thermald.enable = lib.mkDefault true;

  specialisation = {
    dGPU.configuration = {
      system.nixos.tags = ["dGPU"];

      services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
      hardware.nvidia.open = lib.mkOverride 990 (config.hardware.nvidia.package ? open && config.hardware.nvidia.package ? firmware);
      hardware.nvidia = {
        powerManagement = {
          # Enable NVIDIA power management.
          enable = lib.mkDefault true;
        };
      };
    };
  };

  environment.persistence."/persist" = {
    directories = [

    ];
    files = [

    ];
  };

  system.stateVersion = "24.11";
}

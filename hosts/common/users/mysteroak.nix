{ pkgs, inputs, ...}:
{
  users.users.mysteroak = {
    isNormalUser = true;
    password = "2";
    description = "mysteroak";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEEG7T8kPc7dQ0JGq4EYf8usi9TiZJQFrn9iAH+gydbH mysteroak@oakstation"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
}

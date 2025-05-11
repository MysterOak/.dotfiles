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
    openssh.authorizedKeys.keys = [];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
}

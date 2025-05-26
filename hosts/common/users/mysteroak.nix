{ pkgs, inputs, config,...}:
let
  ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.mysteroak = {
    isNormalUser = true;
    initialPassword = "2";
    description = "mysteroak";
    extraGroups = [
      "wheel"
    ]
    ++ ifGroupExists [
      "networkmanager"
      "pipewire"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEEG7T8kPc7dQ0JGq4EYf8usi9TiZJQFrn9iAH+gydbH mysteroak@oakstation"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
}

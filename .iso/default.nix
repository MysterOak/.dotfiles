{pkgs, ...}:
{
  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBU8sp627Zgoy6vp/ndEjQHmvoVo9rnQUJdpZI0oydGT mysteroak@oakstation"
  ];
}

{pkgs, ...}:
{
  programs.fish.enable = true;
  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
  ];

}

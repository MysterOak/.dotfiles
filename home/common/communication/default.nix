{pkgs, ...}:
{
  imports = [
    ./vesktop
  ];

  home.packages = with pkgs; [
    signal-desktop
    thunderbird
  ];

}

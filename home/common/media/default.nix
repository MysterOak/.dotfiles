{pkgs, ...}:
{
  imports = [

  ];
  home.packages = with pkgs; [
    jellyfin-media-player
    spotify-player
    ncspot
  ];
}

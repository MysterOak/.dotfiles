{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vesktop
    beyond-all-reason
  ];
}

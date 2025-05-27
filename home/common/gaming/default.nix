{ pkgs, ... }:
{
  imports = [
  ];
  home.packages = with pkgs; [
    beyond-all-reason
    moonlight-qt
  ];

  #programs.lutris.enable = true;

}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vesktop
  ];

  home.file.".config/vesktop/settings/quickCss.css".source = ./quickCss.css;
  home.file.".config/vesktop/settings/settings.json".source = ./settings.json;
}

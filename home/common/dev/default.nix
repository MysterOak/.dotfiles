{ pkgs, ... }:
{
  programs = {
    ghostty.enable = true;
    gitui.enable = true;

    zed-editor = {
      enable = true;
    };

    git.delta = {
      enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
      enableFishIntegration = true;
    };

    bat = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    ripgrep-all = {
      enable = true;
    };

    fd = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };

    zellij = {
      enable = true;
    };

    starship = {
      enable = true;
    };

    yazi = {
      enable = true;
    };

    tealdeer = {
      enable = true;
    };

    bottom = {
      enable = true;
    };

    skim = {
      enable = true;
    };

    fastfetch = {
      enable = true;
    };

  };

  home.packages = with pkgs; [
    nil
    nixd
    dust
    dua
    hyperfine
    fselect
    tokei
    wiki-tui
    mask
    presenterm
    mprocs
    procs
    sd
    ouch
  ];

  home.file.".config/ghostty/config".source = ./ghosttyconfig;

}

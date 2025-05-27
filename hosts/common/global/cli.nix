{pkgs, ...}:
{
  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    git
    uutils-coreutils-noprefix
    ripgrep
    ripgrep-all
    fd
    bat
    eza
    zoxide
    zellij
    gitui
    dust
    dua
    starship
    yazi
    hyperfine
    fselect
    delta
    tokei
    wiki-tui
    mask
    presenterm
    mprocs
    procs
    tealdeer
    bottom
    sd
    skim
    ouch
    macchina
  ];

}

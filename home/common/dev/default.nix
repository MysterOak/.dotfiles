{ pkgs, lib, ... }:
{
  programs = {
    ghostty.enable = true;

    fish = {
      enable = true;
    };

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
      icons = "auto";
      enableFishIntegration = true;
    };

    bat = {
      enable = true;
    };

    ripgrep = {
      enable = true;
      arguments = [
        # Don't let ripgrep vomit really long lines to my terminal, and show a preview.
        "--max-columns=150"
        "--max-columns-preview"

        # Search hidden files / directories (e.g. dotfiles) by default
        "--hidden"

        # Set the colors.
        "--colors=line:none"
        "--colors=line:style:bold"

        # Because who cares about case!?
        "--smart-case"
      ];
    };

    ripgrep-all = {
      enable = true;
    };

    fd = {
      enable = true;
      hidden = true;
      extraOptions = [];
    };

    zoxide = {
      enable = true;
      options = [];
      enableFishIntegration = true;
    };

    zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$line_break"
          "$package"
          "$line_break"
          "$character"
        ];
        scan_timeout = 10;
        character = {
          success_symbol = "➜";
          error_symbol = "➜";
        };
      };
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        log = {
          enabled = false;
        };
        manager = {
          show_hidden = true;
          show_symlink = true;
          sort_by = "natural";
          sort_translit = true;
          sort_dir_first = true;
          sort_reverse = false;
        };
      };
    };

    tealdeer = {
      enable = true;
    };

    bottom = {
      enable = true;
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
    };

    fastfetch = {
      enable = true;
      settings = (builtins.readFile ./fastfetch.jsonc);
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
  home.file.".config/zed/settings.json".source = ./zed.json;
  home.file.".config/bottom/bottom.toml".source = ./bottom.toml;
}

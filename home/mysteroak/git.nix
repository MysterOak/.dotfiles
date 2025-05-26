{
  programs.git = {
    enable = true;
    userName = "mysteroak";
    userEmail = "leandereicher.info@gmail.com";
    aliases = {
      st = "status";
      logd = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    extraConfig = {
      #core.excludesfile = "~/.gitignore_global";
      #init.defaultBranch = "master";
    };
  };
  }

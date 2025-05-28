{
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "github";
        url = "https://github.com/MysterOak/.dotfiles.git";
        branches.main.name = "main";
      }
    ];
  };
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/comin"
    ];
  };
}

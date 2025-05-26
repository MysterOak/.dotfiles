{ ... }:
{
  users.users.root = {
    initialHashedPassword = "!"; #Effectively disables password auth for the root user
  };
}

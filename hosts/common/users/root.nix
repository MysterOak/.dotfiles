{ ... }:
{
  users.users.root = {
    hashedPassword = "!"; #Effectively disables password auth for the root user
  };
}

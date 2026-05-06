{
  pkgs,
  currentSystemUser,
  ...
}:
{
  imports = [ ];
  networking.hostName = "wsl";
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = currentSystemUser;
    startMenuLaunchers = true;
  };
}

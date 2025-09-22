{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./shared.nix
  ];
  networking.hostName = "laptop";
}

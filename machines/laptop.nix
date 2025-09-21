{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./shared.nix
    ./hardware/t480.nix
  ];
  networking.hostName = "laptop";
}

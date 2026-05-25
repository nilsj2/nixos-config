{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware/legion-y520.nix
    ./shared.nix
  ];

  services.fstrim.enable = true;
  services.thermald.enable = true;

  networking.hostName = "legion-y520";
}

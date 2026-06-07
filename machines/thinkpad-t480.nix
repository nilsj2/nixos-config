{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware/thinkpad-t480.nix
    ./shared.nix
  ];
  # This is the only unique thing nixos-hardware.lenovo-thinkpad-t480 provides
  services.fstrim.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}

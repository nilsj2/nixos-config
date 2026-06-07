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

  services.desktopManager.plasma6.enable = false;
  services.desktopManager.gnome.enable = true;
  # TODO: Test if gdm still is necessary. (probably)
  services.displayManager.ly.enable = false;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.autoSuspend = false;

  # hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # GTX 1060 is older than turing(GTX 1660)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

    prime = {
      sync.enable = true;

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  programs.steam.enable = true;
}

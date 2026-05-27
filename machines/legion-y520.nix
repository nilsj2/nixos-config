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

  # hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # GTX 1060 is older than turing(GTX 1660)
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
      sync.enable = true;

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  programs.steam.enable = true;

  networking.hostName = "legion-y520";
}

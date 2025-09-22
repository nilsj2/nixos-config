{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./shared.nix
    ./hardware/y520.nix
  ];
  networking.hostName = "workstation";

  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # GTX 1060 is older than turing(GTX 1660)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
      sync.enable = true;
      
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.copyparty = {
    enable = true;

    accounts = {
      nilsj.passwordFile = "/home/nilsj/secrets/nilsj_password";
    };

    volumes = {
      "/" = {
        path = "/srv/copyparty";

        access = {
          A = [ "nilsj" ]; # A=Admin
        };
      };
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "nilsj" ];
      PasswordAuthentication = false;
    };
  };
}

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

  services.copyparty = {
    enable = true;

    accounts = {
      nilsj.passwordFile = "/run/keys/copyparty/nilsj_password";
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
}

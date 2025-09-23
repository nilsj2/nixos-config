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
  services.fail2ban.enable = true; # SSH hardening, provides rate-limiting
}

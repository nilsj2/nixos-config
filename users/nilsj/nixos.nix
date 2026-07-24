{ pkgs, inputs, ... }:

{
  environment = {
    localBinInPath = true;
    variables = {
      CLI_COLOR = "1";
      ZIG_BUILD_ERROR_STYLE = "minimal_clear";
    };
  };

  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Configure custom keyboard layout and caps-backspace remapping
  services.xserver.xkb = {
    layout = "se";

    extraLayouts.se-colemak-dhk = {
      description = "Swedish colemak dhk layout";
      languages = [ "se" ];
      symbolsFile = ./xkb/symbols/se-colemak-dhk;
    };
  };

  services.evremap = {
    enable = true;
    settings = {
      device_name = "AT Translated Set 2 keyboard";
      remap = [
        {
          input = [ "KEY_CAPSLOCK" ];
          output = [ "KEY_BACKSPACE" ];
        }
      ];
    };
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  services.displayManager.defaultSession = "sway";

  security.pam.services = {
    swaylock.enableGnomeKeyring = true;
    gdm.enableGnomeKeyring = true;
  };

  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIBjDCCATKgAwIBAgIUUef3uae0wifz6Nw/Z3aEgE9k/+AwCgYIKoZIzj0EAwIw
      JDEQMA4GA1UEChMHcGFydHljbzEQMA4GA1UEAxMHcGFydHljbzAeFw0yNTEwMjgx
      NjA1MDBaFw0zNTEwMjYxNjA1MDBaMCQxEDAOBgNVBAoTB3BhcnR5Y28xEDAOBgNV
      BAMTB3BhcnR5Y28wWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAAQju/kt9HxHehl9
      VgNzrM4b88q6DpQzjmfhfjpO7F1jMsXJfA4WnVG1jBNlYRFaO8yc03/A+oRXVaI8
      j3vatK2mo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNV
      HQ4EFgQUQTJlJjouegj1Q6KhnhfI+xCQ9MMwCgYIKoZIzj0EAwIDSAAwRQIgTCbx
      6tO2lBNn0A9dTPfxbMYQl3S+KgBhpDFuK5bhiiMCIQCbdVIw7huOiGO4yaO1jrmz
      u/4JeBRKAhg1LkaLiFhdYw==
      -----END CERTIFICATE-----
    ''
  ];

  users.users.nilsj = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 3d";
    dates = "weekly";
    randomizedDelaySec = "15min";
  };

  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
      "nixpkgs"
    ];
    flake = "path:/home/nilsj/nixos-config";
    dates = "daily";
    randomizedDelaySec = "15min";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 1;
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

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LANG = "en_GB.UTF-8";
      LANGUAGE = "en_GB.UTF-8";
      LC_CTYPE = "sv_SE.UTF8";
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MESSAGES = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
      LC_COLLATE = "sv_SE.UTF-8";
    };
  };

  services = {
    # Should probably use gnome everywhere, postponing this.
    # Maybe switch to sway on t480.
    desktopManager.plasma6.enable = lib.mkDefault true;
    displayManager.ly.enable = lib.mkDefault true;
    xserver.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  services.displayManager.defaultSession = "sway";

  environment.systemPackages = with pkgs; [
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kclock # Clock app
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    # kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
    kdePackages.filelight
    kdePackages.qtmultimedia
    # kdePackages.plasma-browser-integration

    # Non-KDE graphical packages
    vlc # Cross-platform media player and streaming server
    # wayland-utils # Wayland utilities

  ];

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}

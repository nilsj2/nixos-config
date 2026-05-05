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
    randomizedDelaySec = "45min";
  };

  system.autoUpgrade = {
    enable = true;
    flags = [ "--recreate-lock-file" ];
    flake = "path:/home/nilsj/nixos-config";
    dates = "daily";
    randomizedDelaySec = "45min";
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

  # services.mullvad-vpn = {
  #   enable = true;
  #   package = pkgs.mullvad-vpn;
  # };

  # Window management
  services.xserver.enable = true;

  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;

  # environment.gnome.excludePackages = with pkgs; [
  #   gnome-tour
  #   gnome-user-docs
  # ];

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

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

    rclone # for filesync
  ];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # hardware.bluetooth = {
  #   enable = true;
  #   powerOnBoot = true;
  #   settings = {
  #     General = {
  #       Experimental = true;
  #       FastConnectable = true;
  #     };
  #   };
  # };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

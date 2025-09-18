{ lib, pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "Nils Juto";
      userEmail = "nilsjuto@posteo.net";
      extraConfig.advice.defaultBranchName = false;
    };

    helix = {
      enable = true;
      settings = {
        theme = "onedark";
      };
    };

    spotify-player = {
      enable = true;
      settings = {
        enable_notify = false;
      };
    };

    ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        theme = "OneHalfDark";
      };
    };
  };

  home = {
    packages = with pkgs; [
      lazygit
      tldr
      tree
      fastfetch
      ripgrep
      fd
      bat
      btop
      exercism
      tokei
      poop
      pwgen
      nixfmt-tree
      gdb

      wl-clipboard
      trash-cli

      anki-bin
      vesktop
      firefox
      thunderbird-esr
      gnome-pomodoro
    ];

    username = "nilsj";
    homeDirectory = "/home/nilsj";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.05";
  };
}

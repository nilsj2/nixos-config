{ lib, pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Nils Juto";
          email = "nilsjuto@posteo.net";
        };
        advice.defaultBranchName = false;
      };
      ignores = [ "nils-testing" ];
    };

    gh.enable = true;

    helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor.soft-wrap.enable = true;
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
        theme = "One Half Dark";
      };
    };
  };

  services = {
    tldr-update.enable = true;
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
      file
      uv
      jq
      nixd

      wl-clipboard
      trash-cli

      anki
      vesktop
      firefox
      thunderbird-esr
      evince
      gnome-pomodoro
      libreoffice-qt6-fresh
      hunspell
      hunspellDicts.en_GB-large
      hunspellDicts.sv_SE
    ];

    username = "nilsj";
    homeDirectory = "/home/nilsj";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.05";
  };
}

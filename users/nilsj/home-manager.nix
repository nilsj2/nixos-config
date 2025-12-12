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
        theme = "onelight";
        editor.soft-wrap.enable = true;
        keys.normal = {
          space.q = "@ms{ms{i<esc>llic1::<esc>mami<esc>vh<esc>a<esc>vl<esc>";
        };
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
        theme = "One Half Light";
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
      zls # TODO These things should be in a shell.nix for the associated projncet like mhashimoto.
      pkg-config
      poppler_gi

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

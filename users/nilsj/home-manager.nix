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
        editor = {
          soft-wrap.enable = true;
          line-number = "relative";
        };

        keys.normal = {
          space.q = "@<esc>ms{ms{i<esc>llic1::<esc>mami<esc>vh<esc>a<esc>vl<esc>";
        };

      };
    };

    ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        theme = "light:One Half Light,dark:One Half Dark";
      };
    };

    anki = {
      enable = true;

      answerKeys = [
        {
          ease = 1;
          key = "Z";
        }
        {
          ease = 2;
          key = "2";
        }
      ];

      hideBottomBar = true;
      hideBottomBarMode = "fullscreen";
      hideTopBar = true;
      hideTopBarMode = "fullscreen";
      reduceMotion = true;

      style = "native";
      videoDriver = "vulkan";

      sync = {
        usernameFile = "/home/nilsj/Documents/anki-credentials/username";
        keyFile = "/home/nilsj/Documents/anki-credentials/key";
      };

      addons = [
        pkgs.ankiAddons.review-heatmap
        # TODO: FSRS helper for anki plugin provides some niche things that
        # may be useful.

        # TODO: Progress bar plugin is really good, however currently "maintained"
        # by some dude I don't trust so I should reimplement it or maybe just
        # make my own TUI-anki client :-)
      ];
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
      # exercism
      tokei
      poop
      pwgen
      nixfmt-tree
      gdb
      file
      # uv
      jq
      xxd
      wget
      zip
      unzip

      wl-clipboard
      trash-cli

      librewolf
      thunderbird-esr
      gnome-pomodoro
      libreoffice-qt6-fresh
      hunspell
      hunspellDicts.en_GB-large
      hunspellDicts.sv_SE
      marktext
    ];

    username = "nilsj";
    homeDirectory = "/home/nilsj";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.05";
  };
}

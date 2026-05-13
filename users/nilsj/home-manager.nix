{ isWSL, ... }:

{ lib, pkgs, ... }:
{
  accounts = {
    email.accounts.Personal = {
      primary = true;
      address = "nils.juto@posteo.se";
      userName = "nilsjuto@posteo.net";
      realName = "Nils Juto";
      passwordCommand = "secret-tool lookup email nils.juto@posteo.se";
      signature = {
        showSignature = "append";
        text = ''
          Hälsningar,
          Nils Juto
        '';
      };

      smtp.host = "posteo.de";
      imap.host = "posteo.de";

      aerc.enable = true;
    };

    contact = {
      basePath = "Documents/Contacts";

      accounts.Personal = {
        remote = {
          type = "carddav";
          url = "https://posteo.de:8843/addressbooks/nilsjuto/default";
          userName = "nilsjuto@posteo.net";
          passwordCommand = [
            "secret-tool"
            "lookup"
            "email"
            "nils.juto@posteo.se"
          ];
        };

        vdirsyncer = {
          enable = true;
        };

        khard.enable = true;
        khal.enable = true;
      };
    };

    calendar = {
      basePath = "Documents/Calendars";

      accounts.Personal = {
        remote = {
          type = "caldav";
          url = "https://posteo.de:8843/addressbooks/nilsjuto/default";
          userName = "nilsjuto@posteo.net";
          passwordCommand = [
            "secret-tool"
            "lookup"
            "email"
            "nils.juto@posteo.se"
          ];
        };

        vdirsyncer.enable = true;
        khal.enable = true;
      };

      accounts.School = {
        local = {
          type = "singlefile";
        };

        khal.enable = true;
      };
    };
  };

  programs = {
    aerc = {
      enable = true;

      extraConfig = {
        general.unsafe-accounts-conf = true;
        filters = {
          "text/plain" = "wrap -w 100 | colorize";
          "text/html" = "! w3m -I UTF-8 -T text/html";
          # "text/calendar" = "calendar";
        };

        compose = {
          reply-to-self = false;
          address-book-cmd = "khard email --parsable --search-in-source-files --remove-first-line %s";
        };
      };

      # TODO: https://github.com/nix-community/home-manager/pull/9030
      # extraBinds = {
      #   messages = {
      #     d = "read<Enter>:move Trash<Enter>";
      #   };
      #   "messages:folder=Trash" = {
      #     d = "delete-message<Enter>";
      #   };
      # };

      extraAccounts.Personal = {
        restrict-delete = true;
        folders-sort = [
          "INBOX"
          "Archive"
          "Sent"
          "Drafts"
          "Trash"
        ];
      };
    };

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

    khard.enable = true;
    khal.enable = true;
    vdirsyncer.enable = true;

    fish = {
      enable = true;
      shellAliases = {
        lg = "lazygit";
        nxsh = "nix-shell --run fish -p";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        tree = "tree -C";
      };
      functions = {
        zigdir = "zig any list-installed | grep (zig version) | sed 's/^[^ ]*\\t//'";
      };
    };

    helix = {
      enable = true;
      defaultEditor = true;
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
      enable = !isWSL;
      enableFishIntegration = true;
      settings = {
        theme = "light:One Half Light,dark:One Half Dark";
        font-size = 11;
      };
    };

    anki = {
      enable = !isWSL;

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

      hideTopBar = true;
      hideTopBarMode = "fullscreen";
      reduceMotion = true;

      style = "native";
      videoDriver = "vulkan";

      sync = {
        usernameFile = "/home/nilsj/Documents/anki-credentials/username";
        keyFile = "/home/nilsj/Documents/anki-credentials/key";
      };
    };
  };

  xdg.terminal-exec = {
    enable = !isWSL;
    settings.default = [ "ghostty.desktop" ];
  };

  services = {
    tldr-update.enable = true;
  };

  home = {
    packages =
      with pkgs;
      [
        lazygit
        tldr
        tree
        fastfetch
        ripgrep
        fd
        bat
        btop
        tokei
        poop
        nixfmt-tree
        gdb
        file
        jq
        xxd
        wget
        zip
        unzip
        libsecret
        w3m
        trash-cli
        rclone
      ]
      ++ (lib.optionals (!isWSL) [
        wl-clipboard
        librewolf
        thunderbird-esr
        gnome-pomodoro
        libreoffice-qt6-fresh
        hunspell
        hunspellDicts.en_GB-large
        hunspellDicts.sv_SE
      ]);

    username = "nilsj";
    homeDirectory = "/home/nilsj";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.05";
  };
}

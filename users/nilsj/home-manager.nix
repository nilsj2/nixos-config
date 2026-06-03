{ isWSL, isNvidiaGPU, ... }:

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
          email = "nils.juto@posteo.se";
        };
        advice.defaultBranchName = false;
      };
      ignores = [ "nils-testing" ];
      signing = {
        format = "openpgp";
        signByDefault = true;
      };
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
      ];

      hideTopBar = true;
      hideTopBarMode = "fullscreen";
      reduceMotion = true;
      minimalistMode = true;

      style = "native";
      # videoDriver = "vulkan"; # NOTE: Broken since 26.05

      profiles."Nils".sync = {
        username = "nilsjuto@posteo.net";
        keyFile = "/home/nilsj/Documents/anki-credentials/key";
      };
    };

    qutebrowser = {
      enable = true;
      extraConfig = ''
        c.hints.chars = "arstneio"
        c.scrolling.smooth = True

        config.bind('<Alt-Shift-u>', 'spawn --userscript qute-keepassxc --key 9C8CABD21F883265A81D231F433555B09CA77C0D', mode='insert')
        config.bind('pw', 'spawn --userscript qute-keepassxc --key 9C8CABD21F883265A81D231F433555B09CA77C0D', mode='normal')

        c.url.searchengines = {
          "DEFAULT": "https://duckduckgo.com/?q={}",
          "g": "https://www.google.ie/search?q={}",
          "m": "https://www.openstreetmap.org/search?query={}",
          "y": "http://www.youtube.com/results?search_query={}",
          "tw": "https://www.twitch.tv/search?term={}",
          "ws": "https://sv.wikipedia.org/w/index.php?search={}",
          "we": "https://en.wikipedia.org/w/index.php?search={}",
          "lol": "https://leagueoflegends.fandom.com/wiki/{}",
          "reddit": "https://www.reddit.com/search/?q={}",
          "sub": "https://www.reddit.com/r/{}",
          "mdn": "https://developer.mozilla.org/en-US/search?q={}",
          "sv": "https://svenska.se/tre/?sok={}",
          "en": "https://www.merriam-webster.com/dictionary/{}",
          "syn": "https://www.synonymer.se/sv-syn/{}",
          "u": "https://u.gg/lol/profile/euw1/{}/overview",
          "ensve": "https://sv.glosbe.com/en/sv/{}",
          "sveen": "https://sv.glosbe.com/sv/en/{}",
          "osrs": "https://oldschool.runescape.wiki/w/{}",
          "ol": "https://onelook.com/?w={}",
          "counter": "https://u.gg/lol/champions/{}/counter?region=euw1&rank=diamond_plus",
          "pro": "https://probuildstats.com/champion/{}",
        }
      '';
    };

    gpg.enable = true;

    keepassxc = {
      enable = true;
      autostart = true;
      settings = {
        Browser.Enabled = true;
        Security.LockDatabaseIdle = false;
      };
    };
  };

  xdg = {
    terminal-exec = {
      enable = !isWSL;
      settings.default = [ "ghostty.desktop" ];
    };
    autostart.enable = true;
  };

  services = {
    tldr-update.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-qt;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # TODO: Investigate whether an issue was ever opened
    # https://discourse.nixos.org/t/services-xserver-xkb-extralayouts-doesnt-seem-to-be-compatible-with-sway/46128/4
    checkConfig = false;
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      input."*" = {
        xkb_layout = "se-colemak-dhk";
      };

      input."type:touchpad" = {
        natural_scroll = "enabled";
        tap = "enabled";
      };
      input."type:pointer" = {
        accel_profile = "flat";
        pointer_accel = "0.1";
      };

      output.HDMI-A-1.mode = "1920x1080@144Hz";

      assigns = {
        "1: http" = [
          { app_id = "librewolf"; }
          { app_id = "org.qutebrowser.qutebrowser"; }
        ];
        "2: mail" = [
          {
            app_id = "com.mitchellh.ghostty";
            title = "aerc";
          }
        ];
        "4: anki" = [ { app_id = "anki"; } ];
        "10: pass" = [ { app_id = "org.keepassxc.KeePassXC"; } ];
      };

      startup = [
        { command = "qutebrowser"; }
        { command = "ghostty +new-window --title=aerc -e aerc"; }
        { command = "exec swaymsg 'workspace 3: code; exec ghostty'"; }
        { command = "anki"; }
        { command = "keepassxc"; }
      ];

      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioStop" = "exec playerctl stop";
      };
    };
    extraConfig = if isNvidiaGPU then "output eDP-1 disable" else "";
    extraOptions = if isNvidiaGPU then [ "--unsupported-gpu" ] else [ ];
  };

  systemd.user.services.cpp-mount = {
    Unit = {
      Description = "Copyparty rclone setup";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/cpp";
      ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode writes --dir-cache-time 5s nilssrv-dav: \"%h/cpp\"";
      ExecStop = "/run/wrappers/bin/fusermount -u %h/cpp/%i";
    };
    Install.WantedBy = [ "default.target" ];
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
        gcr
        playerctl
        brightnessctl
      ]
      ++ (
        lib.optionals (!isWSL) [
          wl-clipboard
          librewolf
          thunderbird-esr
          gnome-pomodoro
          libreoffice-qt6-fresh
          hunspell
          hunspellDicts.en_GB-large
          hunspellDicts.sv_SE
          rofi
        ]
        ++ (lib.optionals (!isWSL && isNvidiaGPU) [
          vesktop
        ])
      );

    username = "nilsj";
    homeDirectory = "/home/nilsj";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.05";
  };
}

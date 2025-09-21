{ pkgs, inputs, ... }:

{
  environment.localBinInPath = true;

  programs.fish.enable = true;

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

  users.users.nilsj = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
}

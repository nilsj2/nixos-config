{
  nixpkgs,
  home-manager,
  inputs,
}:

name:
{
  system,
  user,
  wsl ? false,
  nvidia ? false,
}:

let
  isWSL = wsl;
  isNvidiaGPU = nvidia;

  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/nixos.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

  inherit (nixpkgs.lib) optionals;
in
nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules =
    optionals isWSL [
      inputs.nixos-wsl.nixosModules.wsl
    ]
    ++ [
      { nixpkgs.config.allowUnfree = isNvidiaGPU; }
      { networking.hostName = name; }

      machineConfig
      userOSConfig

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import userHMConfig {
          isWSL = isWSL;
          isNvidiaGPU = isNvidiaGPU;
        };
      }

      # This allows modules paramaratize better (from Hashimoto)
      {
        config._module.args = {

          currentSystem = system;
          currentSystemName = name;
          currentSystemUser = user;
          isWSL = isWSL;
          isNvidiaGPU = isNvidiaGPU;
          inputs = inputs;
        };
      }

    ];
}

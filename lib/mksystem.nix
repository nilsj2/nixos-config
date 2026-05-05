{
  nixpkgs,
  home-manager,
  inputs,
}:

name:
{
  system,
  user,
}:

let
  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/nixos.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

in
nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    machineConfig
    userOSConfig

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = userHMConfig;
    }

    # This allows modules paramaratize better (from Hashimoto)
    {
      config._module.args = {

        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        inputs = inputs;
      };
    }

  ];
}

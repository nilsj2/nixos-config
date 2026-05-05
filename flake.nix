{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix {
        inherit nixpkgs home-manager inputs;
      };
    in
    {
      nixosConfigurations.thinkpad-t480 = mkSystem "thinkpad-t480" {
        system = "x86_64-linux";
        user = "nilsj";
      };
    };
}

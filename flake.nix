{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      copyparty,
    }:
    let
      homeManagerSetup = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nilsj = ./users/nilsj/home-manager.nix;
        }
      ];
    in
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        modules = [
          ./users/nilsj/nixos.nix
          ./machines/workstation.nix
          copyparty.nixosModules.default
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ copyparty.overlays.default ];
              environment.systemPackages = [ pkgs.copyparty ];
              services.copyparty.enable = true;
            }
          )
        ]
        ++ homeManagerSetup;
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./users/nilsj/nixos.nix
          ./machines/laptop.nix
        ]
        ++ homeManagerSetup;
      };
    };
}

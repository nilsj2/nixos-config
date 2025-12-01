{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }@inputs:
    let
      homeManagerSetup = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nilsj = ./users/nilsj/home-manager.nix;
        }
      ];

      overlays = [
        (final: prev: {
          anki = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.anki;
        })
      ];
    in
    {

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        modules = [
          { networking.hostName = "laptop"; }
          { nixpkgs.overlays = overlays; }
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ./machines/hardware/t480.nix
          ./machines/shared.nix
          ./users/nilsj/nixos.nix
          {
            swapDevices = [
              {
                device = "/var/lib/swapfile";
                size = 16 * 1024;
              }
            ];
          }
        ]
        ++ homeManagerSetup;
      };
    };
}

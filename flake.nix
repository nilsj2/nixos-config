{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
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

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        modules = [
          { networking.hostName = "laptop"; }
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

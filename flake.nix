{
  description = "Asliddin's NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager/release-25.05";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.expertlab = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        # home-manager.nixosModules.home-manager
        # {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        # }
      ];
    };
  };
}

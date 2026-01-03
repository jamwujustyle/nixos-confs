{
  description = "Lord's NixOS Flake Configuration";

  inputs = {
    # We use unstable for the latest packages (Go, VSCode, etc.)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    antigravity-nix = {
	url = "github:jacopone/antigravity-nix";
	inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
    
      nixos-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
    };
  };
}

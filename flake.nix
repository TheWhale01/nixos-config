{
	description = "NixOS system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		stylix.url = "github:danth/stylix";
		home-manager.url = "github:nix-community/home-manager";
	};

	outputs = {self, nixpkgs, home-manager, stylix, ... }:
		let
			system = "x86_64-linux";
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
		in {
		nixosConfigurations = {
			nix-whale = lib.nixosSystem {
				inherit system;
				modules = [
					./configuration.nix
				];
			};

		};
		homeConfigurations = {
			whale = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [
					stylix.homeManagerModules.stylix
					./home-manager/home.nix
				];
			};
		};
	};
}

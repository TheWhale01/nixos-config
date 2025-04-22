{
	description = "NixOS system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		stylix.url = "github:danth/stylix/release-24.11";
		home-manager.url = "github:nix-community/home-manager/release-24.11";
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

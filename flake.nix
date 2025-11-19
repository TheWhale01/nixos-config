{
	description = "whale's NixOS";

	inputs = {
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			url = "github:danth/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, nixos-hardware, home-manager, agenix, disko, stylix, ... }@inputs:
	let
		defaultSystem = "x86_64-linux";
		lib = nixpkgs.lib;
		pkgsFor = system: import nixpkgs {
			inherit system;
			config.allowUnfree = true;
			config.allowBroken = true;
		};
	in {
		nixosConfigurations = {
			erebos = lib.nixosSystem {
				system = defaultSystem;
				pkgs = pkgsFor defaultSystem;
				modules = [
					./hosts/erebos/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.hades = import ./hosts/erebos/home.nix;
						home-manager.backupFileExtension = "bkp";
					}
					agenix.nixosModules.default
					disko.nixosModules.disko
				];
			};
			pontos = lib.nixosSystem {
				system = defaultSystem;
				pkgs = pkgsFor defaultSystem;
				specialArgs = { inherit inputs; };
				modules = [
					./hosts/pontos/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.poseidon = import ./hosts/pontos/home.nix;
						home-manager.backupFileExtension = "bkp";
					}
					stylix.nixosModules.stylix
					disko.nixosModules.disko
					nixos-hardware.nixosModules.framework-amd-ai-300-series
				];
			};
			olympos = lib.nixosSystem {
				system = defaultSystem;
				pkgs = pkgsFor defaultSystem;
				specialArgs = { inherit inputs; };
				modules = [
					./hosts/olympos/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.zeus = import ./hosts/olympos/home.nix;
						home-manager.backupFileExtension = "bkp";
					}
					stylix.nixosModules.stylix
				];
			};
			strategos = lib.nixosSystem {
				system = "aarch64-linux";
				pkgs = pkgsFor "aarch64-linux";
				modules = [
					./hosts/strategos/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.athena = import ./hosts/strategos/home.nix;
						home-manager.backupFileExtension = "bkp";
					}
					agenix.nixosModules.default
				];
			};
		};
	};
}

{
	description = "whale's NixOS";

	inputs = {
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
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
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		pkgs = import nixpkgs {
			system = "${system}";
			config.allowUnfree = true;
		};
	in {
		nixosConfigurations = {
			erebos = lib.nixosSystem {
				inherit system;
				inherit pkgs;
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
				inherit system;
				inherit pkgs;
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
				inherit system;
				inherit pkgs;
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
		};
	};
}

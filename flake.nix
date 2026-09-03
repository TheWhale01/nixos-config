{
	description = "whale's NixOS";

	inputs = {
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
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
			inputs.home-manager.follows = "home-manager";
		};
    modules = {
      url = "github:TheWhale01/nixos-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kiln = {
      url = "github:otaleghani/kiln";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    hyprconf = {
      # url = "github:TheWhale01/hyprconf";
      url = "path:/home/poseidon/code/hyprconf";
      flake = false;
    };
    quickconf = {
      url = "path:/home/poseidon/code/quickconf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};
	outputs = {
	  nixpkgs,
		nixos-hardware,
		home-manager,
		disko,
		stylix,
		modules,
		nix-flatpak,
		quickconf,
		...
	}@inputs:
	let
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		pkgs = import nixpkgs {
			system = "${system}";
			config.allowUnfree = true;
			config.permittedInsecurePackages = [
				"electron-39.8.10"
			];
		};
	in {
		nixosConfigurations = {
			pontos = lib.nixosSystem {
				inherit system;
				inherit pkgs;
				specialArgs = { inherit inputs; };
				modules = [
					./sys/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.poseidon = import ./sys/home.nix;
						home-manager.backupFileExtension = "bkp";
						home-manager.extraSpecialArgs = { inherit inputs; };
					}
					stylix.nixosModules.stylix
					disko.nixosModules.disko
					nixos-hardware.nixosModules.common-hidpi
					nixos-hardware.nixosModules.framework-amd-ai-300-series
					modules.nixosModules.system
					nix-flatpak.nixosModules.nix-flatpak
					quickconf.nixosModules.default
				];
			};
		};
	};
}

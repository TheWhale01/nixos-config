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
		};
		jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		eden-emulator = {
      url = "path:/home/poseidon/code/eden";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hydenix = {
      url = "github:richen604/hydenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = { nixpkgs, nixos-hardware, home-manager, disko, stylix, jovian, hydenix, ... }@inputs:
	let
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		pkgs = import nixpkgs {
			system = "${system}";
			config.allowUnfree = true;
			config.checkConfig = false;
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
					}
					stylix.nixosModules.stylix
					disko.nixosModules.disko
					nixos-hardware.nixosModules.common-gpu-amd
					nixos-hardware.nixosModules.common-cpu-amd
					nixos-hardware.nixosModules.common-hidpi
					nixos-hardware.nixosModules.common-pc-laptop
					nixos-hardware.nixosModules.common-pc-ssd
					nixos-hardware.nixosModules.framework-amd-ai-300-series
					jovian.nixosModules.default
					# hydenix.nixosModules.default
				];
			};
		};
	};
}

{
  description = "whale's NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
    blog-builder = {
      url = "path:/home/hades/code/blog-builder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cleanerr = {
      url = "github:TheWhale01/cleanerr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    authentik = {
      url = "github:nix-community/authentik-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    modules = {
      url = "github:TheWhale01/nixos-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      agenix,
      disko,
      blog-builder,
      cleanerr,
      authentik,
      modules,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = "${system}";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        erebos = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          specialArgs = { inherit inputs; };
          modules = [
            ./sys/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hades = import ./sys/home.nix;
              home-manager.backupFileExtension = "bkp";
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
            agenix.nixosModules.default
            disko.nixosModules.disko
            blog-builder.nixosModules.default
            cleanerr.nixosModules.default
            authentik.nixosModules.default
          ];
        };
      };
    };
}

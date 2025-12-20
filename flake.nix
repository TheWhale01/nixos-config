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
    };
  };

  outputs =
  {
    nixpkgs,
    home-manager,
    agenix,
    disko,
    blog-builder,
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
        modules = [
          ./sys/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hades = import ./sys/home.nix;
            home-manager.backupFileExtension = "bkp";
          }
          agenix.nixosModules.default
          disko.nixosModules.disko
          blog-builder.nixosModules.default
        ];
      };
    };
  };
}

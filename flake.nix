{
  description = "whale's NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blog-builder = {
      url = "github:TheWhale01/blog-builder";
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
      url = "path:/home/hades/nixos-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    terranix = {
      url = "github:terranix/terranix";
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
      terranix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
      erebosConfig = lib.nixosSystem {
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
          modules.nixosModules.system
        ];
      };
      terranixState =  terranix.lib.terranixConfiguration {
        inherit system;
        modules = [ ./sys/terraform ];
        extraArgs = {
          erebos = erebosConfig;
        };
      };
    in
    {
      nixosConfigurations.erebos = erebosConfig;
      apps.${pkgs.stdenv.hostPlatform.system}.apply = {
        type = "app";
        program = toString (pkgs.writers.writeBash "apply" ''
          if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
          cp ${terranixState} config.tf.json
          ${pkgs.opentofu}/bin/tofu init
          ${pkgs.opentofu}/bin/tofu apply
        '');
      };
    };
}

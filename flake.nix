{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    main.url = "github:name-snrl/nixos-configuration";

    #flake-registry = {
    #  url = "github:nixos/flake-registry";
    #  flake = false;
    #};

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:t184256/nix-on-droid/master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-on-droid, main, ... }: {

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [
        #main.nixosModules.fish
        #main.nixosModules.git
        #main.nixosModules.aliases
        main.nixosModules.nix
        { nix.settings.trusted-users = nixpkgs.lib.mkForce [ "root" "@wheel" ]; }
        ./nix-on-droid.nix
      ];

      extraSpecialArgs = { inherit inputs; };

      pkgs = import nixpkgs {
        system = "aarch64-linux";
        overlays = [ nix-on-droid.overlays.default main.overlay ];
      };
    };

  };
}

{
  description = "Darwin system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    # nix-darwin
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen Browser
    zen-browser.url = "github:youwen5/zen-browser-flake";
    # optional, but recommended if you closely follow NixOS unstable so it shares
    # system libraries, and improves startup time
    # NOTE: if you experience a build failure with Zen, the first thing to check is to remove this line!
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";


    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";


  };

  outputs = inputs@{ nixpkgs, darwin, home-manager, self, ... }:
  let
    system = "x86_64-darwin";  # Change this to x86_64-darwin if you're on Intel Mac
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
    {

    darwinConfigurations."your-hostname" = darwin.lib.darwinSystem {  # Replace your-hostname with your Mac's hostname
      inherit system;
      specialArgs = { inherit inputs pkgs; };
      modules = [
        # Base configuration
        ./configuration.nix

        # Home Manager configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tinus = import ./home.nix;
        }

        # Import your modules (they will need to be made Darwin-compatible)
        ../../homeManagerModules
      ];
    };

    homeManagerModules.default = ../../homeManagerModules;

  };
}

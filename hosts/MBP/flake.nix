{
  description = "NixOS configuration";

  nixConfig = {
     extra-substituters = ["https://cache.soopy.moe"];
     extra-trusted-public-keys = ["cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="];
   };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:mkorje/nixos-hardware"; #Using mkorje's fork for fixed T2 support
    # Hyprland, the Wayland compositor
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # Niri, a Wayland compositor
    niri-flake.url = "github:sodiboo/niri-flake";
    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Stylix 
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      # Optional, by default this flake follows nixpkgs-unstable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, hyprland, hyprland-plugins, stylix, self, sddm-sugar-candy-nix, niri-flake, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = builtins.attrValues self.overlays;
      config.allowUnfree = true;
    };
  in
    {
    # Custom packages (Derivations) for the system
    packages.${system} = {
      cirno-downloader = pkgs.callPackage ../../pkgs/cirno-downloader.nix {};
      bibata-hyprcursor = pkgs.callPackage ../../pkgs/bibata-hyprcursor.nix {};
      future-cursors = pkgs.callPackage ../../pkgs/future-cursors.nix {};
    };
    # Make Derivations accessible in the flake
    overlays = {
      default = final: prev: {
        wine = prev.wineWowPackages.stable;
        cirno-downloader = prev.callPackage ../../pkgs/cirno-downloader.nix {};
        bibata-hyprcursor = prev.callPackage ../../pkgs/bibata-hyprcursor.nix {};
        future-cursors = prev.callPackage ../../pkgs/future-cursors.nix {};
      };
      niri = niri-flake.overlays.niri;
      noGtksourceviewCheck = final: prev: {
        gtksourceview = prev.gtksourceview.overrideAttrs (old: {
        doCheck = false;
      });
     };
    };

    nixosConfigurations = {
      nixosMBP = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./home-manager.nix
          ../../nixosModules

          nixos-hardware.nixosModules.apple-t2 # only for Apple T2 hardware. PUT IN OUTPUTS IF ENABLED
          home-manager.nixosModules.home-manager
          sddm-sugar-candy-nix.nixosModules.default
          stylix.nixosModules.stylix

          {
            nixpkgs.overlays = [ 
              self.overlays.default 
              self.overlays.niri
              sddm-sugar-candy-nix.overlays.default
              self.overlays.noGtksourceviewCheck
            ];
          }
        ];
      };
    };
    homeManagerModules = {
      niri = niri-flake.homeModules.niri;
      default = ../../homeManagerModules;
    };

  };
}
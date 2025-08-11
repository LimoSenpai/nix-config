{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Hyprland, the Wayland compositor
    hyprland.url = "github:hyprwm/Hyprland";
    # Niri, a Wayland compositor
    niri-flake.url = "github:sodiboo/niri-flake";
    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fx-autoconfig = {
      url = "github:MrOtherGuy/fx-autoconfig";
      flake = false;
    };
    sine = {
      url = "github:CosmoCreeper/Sine";
      flake = false;
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

  outputs = inputs@{ nixpkgs, home-manager, hyprland, stylix, self, sddm-sugar-candy-nix, niri-flake, ... }:
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
      gdk-pixbuf-dev = pkgs.gdk-pixbuf.dev;
    };
    # Make Derivations accessible in the flake
    overlays = {
      default = final: prev: {
        wine = prev.wineWowPackages.stable;
        cirno-downloader = prev.callPackage ../../pkgs/cirno-downloader.nix {};
        gdk-pixbuf-dev = pkgs.gdk-pixbuf.dev;
      };
      niri = niri-flake.overlays.niri;
    };

    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./home-manager.nix
          ../../nixosModules

          home-manager.nixosModules.home-manager
          sddm-sugar-candy-nix.nixosModules.default
          stylix.nixosModules.stylix

          {
            nixpkgs.overlays = [ 
              self.overlays.default 
              self.overlays.niri
              sddm-sugar-candy-nix.overlays.default
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

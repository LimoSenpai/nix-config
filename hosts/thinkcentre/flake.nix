{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # was: github:nixos/nixpkgs/nixos-25.05
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager"; # was: github:nix-community/home-manager/release-25.05
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Hyprland, the Wayland compositor
    hyprland.url = "github:hyprwm/Hyprland";
    # Niri, a Wayland compositor
    niri-flake.url = "github:sodiboo/niri-flake";

    # Zen Browser
    zen-browser.url = "github:youwen5/zen-browser-flake";
    # optional, but recommended if you closely follow NixOS unstable so it shares
    # system libraries, and improves startup time
    # NOTE: if you experience a build failure with Zen, the first thing to check is to remove this line!
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    fx-autoconfig-src = {
      url = "github:MrOtherGuy/fx-autoconfig";  # flake.lock pins exact commit
      flake = false;
    };

    sine-src = {
      url = "github:CosmoCreeper/Sine/v2.2.1";  # pins the tag
      flake = false;
    };
    
    # Stylix 
    stylix = {
      url = "github:nix-community/stylix"; # was: github:nix-community/stylix/release-25.05
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";


  };

  outputs = inputs@{ nixpkgs, home-manager, hyprland, stylix, self, niri-flake, spicetify-nix, zen-browser, ... }:
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
      point-er-cursors = pkgs.callPackage ../../pkgs/point-er-cursors.nix {};
      gdk-pixbuf-dev = pkgs.gdk-pixbuf.dev;
      sddm-astronaut-hyprland_kath = pkgs.callPackage ../../pkgs/sddm-astronaut.nix {};
    };
    # Make Derivations accessible in the flake
    overlays = {
    default = final: prev:
      {
        # dein restliches Overlay-Zeug:
        wine = prev.wineWowPackages.stable;
        cirno-downloader = prev.callPackage ../../pkgs/cirno-downloader.nix {};
        bibata-hyprcursor = prev.callPackage ../../pkgs/bibata-hyprcursor.nix {};
        future-cursors = prev.callPackage ../../pkgs/future-cursors.nix {};
        gdk-pixbuf-dev = prev.gdk-pixbuf.dev; 
        point-er-cursors = prev.callPackage ../../pkgs/point-er-cursors.nix {};
        sddm-astronaut-hyprland_kath = prev.callPackage ../../pkgs/sddm-astronaut.nix {};
      };

    niri = niri-flake.overlays.niri;
  };

    nixosConfigurations = {
      nixos-thinkcentre = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./home-manager.nix
          ../../nixosModules

          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          spicetify-nix.nixosModules.spicetify 


          {
            nixpkgs.overlays = [ 
              self.overlays.default 
              self.overlays.niri
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

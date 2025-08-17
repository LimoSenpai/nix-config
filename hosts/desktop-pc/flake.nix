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

  outputs = inputs@{ nixpkgs, home-manager, hyprland, stylix, self, sddm-sugar-candy-nix, niri-flake, zen-browser, ... }:
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
  default = final: prev:
    let
      zenPkgs = inputs.zen-browser.packages.${final.system};
    in {
      # Zen with fx-autoconfig
zen-browser = final.stdenvNoCC.mkDerivation {
  pname = "zen-browser-with-autoconfig";
  version = (inputs.zen-browser.packages.${final.system}.zen-browser.version or "unstable");
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    # wichtig: Rechte zurücksetzen, sonst bleibt alles read-only
    cp -r --no-preserve=mode,ownership ${inputs.zen-browser.packages.${final.system}.zen-browser}/* $out/

    appdir="$out/lib/zen"
    [ -d "$appdir" ] || appdir="$out/lib/firefox"

    install -Dm444 ${inputs.fx-autoconfig-src}/program/config.js \
      "$appdir/config.js"
    install -Dm444 ${inputs.fx-autoconfig-src}/program/defaults/pref/config-prefs.js \
      "$appdir/defaults/pref/config-prefs.js"
  '';
};


      # (optional) keep an alias
      zen-with-fx-autoconfig = final.zen-browser;

      # dein restliches Overlay-Zeug:
      wine = prev.wineWowPackages.stable;
      cirno-downloader = prev.callPackage ../../pkgs/cirno-downloader.nix {};
      gdk-pixbuf-dev = prev.gdk-pixbuf.dev;
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

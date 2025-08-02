{
  description = "NixOS configuration";

  # nixConfig = {
  #   extra-substituters = ["https://cache.soopy.moe"];
  #   extra-trusted-public-keys = ["cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="];
  # };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware"; #Only for Apple T2 hardware. PUT IN OUTPUTS IF ENABLED
    # Hyprland, the Wayland compositor
    hyprland.url = "github:hyprwm/Hyprland";
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

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, hyprland, stylix, self, sddm-sugar-candy-nix, niri-flake, ... }:
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
      cirno-downloader = pkgs.callPackage ./pkgs/cirno-downloader.nix {};
    };
    # Make Derivations accessible in the flake
    overlays = {
      default = final: prev: {
        wine = prev.wineWowPackages.stable;
        cirno-downloader = prev.callPackage ./pkgs/cirno-downloader.nix {};
      };
      niri = niri-flake.overlays.niri;
    };

    nixosConfigurations = {
      nixosMBP = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/MBP/configuration.nix
          ./hosts/MBP/home-manager.nix
          ./nixosModules

          nixos-hardware.nixosModules.apple-t2 # only for Apple T2 hardware. PUT IN OUTPUTS IF ENABLED
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
      default = ./homeManagerModules;
    };

  };
}

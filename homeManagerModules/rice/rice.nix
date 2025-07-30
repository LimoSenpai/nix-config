{inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = 
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
    ];
    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];
  };

  home.packages =  with pkgs; [
    rofi-wayland
    rofi-power-menu
    swww
    waypaper
    rose-pine-cursor

    power-profiles-daemon
    gamemode
    playerctl

  ];
  
  stylix.targets.waybar.enable = true;
  
}


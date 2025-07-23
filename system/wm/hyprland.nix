{inputs, pkgs, ...}: 
{
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

   environment.systemPackages = with pkgs; [
    dunst
    libnotify
    swww
    
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
   ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; 
    NIXOS_OZONE = "1"; 
  };
}

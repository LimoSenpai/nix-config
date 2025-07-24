{ config, pkgs, ... }: 
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "hyprland_kath";
  };
  
  environment.systemPackages = [
    pkgs.kdePackages.sddm
    pkgs.sddm-astronaut
    pkgs.kdePackages.sddm-kcm
  ];
}

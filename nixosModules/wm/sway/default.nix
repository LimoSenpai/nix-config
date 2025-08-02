{ inputs, pkgs, lib, config, stylix, ...}: {

  options = {
    sway.enable = lib.mkEnableOption "Sway";
  };

  config = lib.mkIf config.sway.enable {
    programs.sway = {
      enable = true;
    };
      
    environment.systemPackages = with pkgs; [
        (waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          })
        )
      ];
  };
}
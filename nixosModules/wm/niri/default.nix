{ inputs, pkgs, lib, config, ...}: {

  options = {
    niri.enable = lib.mkEnableOption "Niri";
  };

  config = lib.mkIf config.niri.enable {
    programs.niri = {
      enable = true;
      package = [ pkgs.niri-stable ];
    };

    environment.systemPackages = with pkgs; [
      (waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        })
      )
    ];
  };
}

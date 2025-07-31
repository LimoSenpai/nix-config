{ inputs, pkgs, lib, config, ... }: {

  options = {
    wleave.enable = lib.mkEnableOption "Wleave - Window Leaver";
  };

  config = lib.mkIf config.wleave.enable {
    environment.systemPackages = with pkgs; [
      wleave
    ];
  };
}


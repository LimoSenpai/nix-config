{ inputs, pkgs, lib, config, ... }: {

  options = {
    gui_utils.enable = lib.mkEnableOption "GuI Utilities";
  };

  config = lib.mkIf config.gui_utils.enable {
    environment.systemPackages = with pkgs; [
      geekbench
    ];
  };
}


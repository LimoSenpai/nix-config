{ inputs, pkgs, lib, config, ... }: {

  options = {
    arrpc.enable = lib.mkEnableOption "ARRPC";
  };

  config = lib.mkIf config.arrpc.enable {
    home.packages =  with pkgs; [
    arrpc
    ];
  };
}
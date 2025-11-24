{ config, lib, pkgs, inputs, ... }:
{
  options.noctalia.enable = lib.mkEnableOption "Noctalia quickshell-based shell";

  config = lib.mkIf config.noctalia.enable {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.system}.default
    ];
  };
}

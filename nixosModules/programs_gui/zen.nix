{ pkgs, inputs, lib, config, ... }: {

  options = {
    zen-browser.enable = lib.mkEnableOption "Zen Browser";
  };

  config = lib.mkIf config.zen-browser.enable {
    nixos-apps-gui.extraPackages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };
}

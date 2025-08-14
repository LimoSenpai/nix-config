{ inputs, pkgs, lib, config, ... }: {

  options = {
    element.enable = lib.mkEnableOption "Client for Matrix.org";
  };

  config = lib.mkIf config.element.enable {
    environment.systemPackages = with pkgs; [
      element-desktop
      keepassxc
    ];
  };
}


{ inputs, pkgs, lib, config, ... }: {

  options = {
    amd-radeon.enable = lib.mkEnableOption "AMD Radeon - Display Management";
  };

  config = lib.mkIf config.amd-radeon.enable {
    environment.systemPackages = with pkgs; [
      mesa-demos
      radeon-profile
    ];
  };
}


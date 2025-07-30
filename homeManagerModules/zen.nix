{ config, inputs, lib, pkgs, ... }: {

  imports = [   
    inputs.zen-browser.homeModules.beta
    # inputs.zen-browser.homeModules.twilight
    # inputs.zen-browser.homeModules.twilight-official
  ];

  options = {
    zen.enable = lib.mkEnableOption "Zen Browser";
  };

  config = lib.mkIf config.zen.enable {

    programs.zen-browser = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisableAppUpdate = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
  };
}

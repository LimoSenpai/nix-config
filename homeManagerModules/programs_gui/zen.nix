{ config, inputs, lib, pkgs, stylix,... }: {

  imports = [   
    inputs.zen-browser.homeModules.beta
    # inputs.zen-browser.homeModules.twilight
    # inputs.zen-browser.homeModules.twilight-official
  ];

  options = {
    zen.enable = lib.mkEnableOption "Zen Browser";
  };

  config = lib.mkIf config.zen.enable {
    stylix.targets.zen-browser.profileNames = [
      "fbzuf3jk.Default Profile"
    ];
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

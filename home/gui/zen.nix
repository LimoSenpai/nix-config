{ config, inputs, lib, pkgs, ... }:
{
  # home.nix
  imports = [
    # inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight
    inputs.zen-browser.homeModules.twilight-official
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
}

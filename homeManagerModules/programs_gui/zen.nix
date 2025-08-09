<<<<<<< HEAD
{ config, inputs, lib, pkgs, ... }:
=======
{ config, inputs, lib, pkgs, stylix,... }: {
>>>>>>> 069da2c60fc432d530689fceb4359eecb15f9ab0

let
  fxCfg = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
    sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
  };

<<<<<<< HEAD
  # mozilla.cfg / autoconfig uses pref("k", v); user.js uses user_pref("k", v);
  cfgAsUserJs =
    lib.replaceStrings [ "pref(" ] [ "user_pref(" ] (builtins.readFile fxCfg);
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  options.zen.enable = lib.mkEnableOption "Zen Browser";

  config = lib.mkIf config.zen.enable {
=======
  config = lib.mkIf config.zen.enable {
    stylix.targets.zen-browser.profileNames = [
      "fbzuf3jk.Default Profile"
    ];
>>>>>>> 069da2c60fc432d530689fceb4359eecb15f9ab0
    programs.zen-browser = {
      enable = true;

      # Let the module handle wrapping; just feed it prefs/policies.
      profiles.default = {
        id = 0;
        isDefault = true;
        extraConfig = cfgAsUserJs;
        # or use `settings = { "browser.startup.homepage" = "…"; }` for key/value prefs
      };

      policies = {
        DisableTelemetry = true;
        DisableAppUpdate = false;
        EnableTrackingProtection = {
          Value = true; Locked = true; Cryptomining = true; Fingerprinting = true;
        };
      };
    };
  };
}

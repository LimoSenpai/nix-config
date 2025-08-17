# homeManagerModules/programs_gui/sine.nix
{ lib, config, inputs, ... }:

let
  fxSrc   = inputs.fx-autoconfig-src;  # flake input (flake = false)
  sineSrc = inputs.sine-src;           # flake input (flake = false)
in
{
  options.zen-sine = {
    enable = lib.mkEnableOption "Install Sine (userChromeJS) into a Zen profile";

    # Example: ".zen/fbzuf3jk.Default Profile"  (from Zen → about:support → Root Directory)
    profilePath = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Relative path under $HOME to the Zen profile directory.
        e.g. ".zen/<hash>.Default Profile"
      '';
      example = ".zen/fbzuf3jk.Default Profile";
    };
  };

  config = lib.mkIf config.zen-sine.enable {
    assertions = [
      {
        assertion = config.zen-sine.profilePath != "";
        message   = "zen-sine.profilePath must be set (e.g. .zen/<hash>.Default Profile).";
      }
      {
        assertion = !(lib.hasPrefix "/" config.zen-sine.profilePath);
        message   = "zen-sine.profilePath must be relative to $HOME (omit leading /).";
      }
    ];

    home.file = {
      zenFxJs = {
        target = "${config.zen-sine.profilePath}/chrome/JS";
        source = "${fxSrc}/profile/chrome/JS";
        recursive = true;
      };
      zenFxUtils = {
        target = "${config.zen-sine.profilePath}/chrome/utils";
        source = "${fxSrc}/profile/chrome/utils";
        recursive = true;
      };
      zenFxResources = {
        target = "${config.zen-sine.profilePath}/chrome/resources";
        source = "${fxSrc}/profile/chrome/resources";
        recursive = true;
      };
      zenSineScript = {
        target = "${config.zen-sine.profilePath}/chrome/JS/sine.uc.mjs";
        source = "${sineSrc}/sine.uc.mjs";
      };

      # Create user.js if it doesn't exist (won't clobber if you already manage it)
      zenUserJs = {
        target = "${config.zen-sine.profilePath}/user.js";
        text = ''
          // added by HM zen-sine
          user_pref("userChromeJS.enabled", true);
          user_pref("userChromeJS.allow.insecureScripts", true);
          user_pref("userChromeJS.load.content", true);
          user_pref("userChromeJS.load.chromeInContent", true);
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        '';
        force = false;
      };
    };
  };
}

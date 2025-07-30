{ inputs, pkgs, lib, config, ... }: {
  
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  options = {
    spicetify.enable = lib.mkEnableOption "Spicetify";
  };

  config = lib.mkIf config.spicetify.enable {
    programs.spicetify = 
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];
    };
  };
}


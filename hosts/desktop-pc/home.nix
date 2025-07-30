{ config, lib, pkgs, inputs, ... }:

{
  home.username = "tinus";
  home.homeDirectory = "/home/tinus";
  
  imports = [ 
      ../../homeManagerModules
    ];

  home.sessionVariables = {
    XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:/usr/share";
    BROWSER = "zen";
    EDITOR = "nano";
    TERMINAL = "kitty";
  };
  

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}

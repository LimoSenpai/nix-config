{ inputs, pkgs, lib, config, ... }: {

  options = {
    cli_utilities.enable = lib.mkEnableOption "CLI Utilities";
  };

  config = lib.mkIf config.cli_utilities.enable {
    home.packages =  with pkgs; [
      
      fastfetch
      neofetch
      yazi
      
      grimblast # Screenshot tool
      
      mdadm
      jq

      zip
      xz
      unzip
      p7zip
      kdePackages.ark

      eza # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder

      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg

      btop
      iotop
      iftop

      lsof

      sysstat
      lm_sensors 
      ethtool
      pciutils
      usbutils

      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor
    ];
  };
}


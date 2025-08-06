{ inputs, pkgs, lib, config, ... }: {

  options = {
    cli_utilities.enable = lib.mkEnableOption "CLI Utilities";
  };

  config = lib.mkIf config.cli_utilities.enable {
    environment.systemPackages = with pkgs; [
      git
      nano
      wget
      bluez
      glib
      zip
      xz
      unzip
      p7zip
      kdePackages.ark
      nvtopPackages.v3d

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
      nvtopPackages.v3d

      lsof

      sysstat
      lm_sensors 
      ethtool
      pciutils
      usbutils
    ];
  };
}


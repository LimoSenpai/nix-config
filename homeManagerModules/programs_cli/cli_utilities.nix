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

      hyperfine
      

      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor
    ];
  };
}


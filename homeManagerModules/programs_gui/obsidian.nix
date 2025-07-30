{ inputs, pkgs, lib, config, ... }: {

  options = {
    obsidian.enable = lib.mkEnableOption "Obsidian - Note-taking App";
  };

  config = lib.mkIf config.obsidian.enable {
    home.packages =  with pkgs; [
      obsidian
    ];
  };
}
{ inputs, pkgs, lib, config, ... }: {

  options = {
    vscode.enable = lib.mkEnableOption "Visual Studio Code - Code Editing";
  };

  config = lib.mkIf config.vscode.enable {
    home.packages =  with pkgs; [
      vscode-fhs
    ];
  };
}
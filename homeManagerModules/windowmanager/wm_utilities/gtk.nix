{ inputs, pkgs, lib, config, ... }: {

  #options = {
  #  cursor.enable = lib.mkEnableOption "Cursor Theme";
  #};

  #config = lib.mkIf config.cursor.enable {
    home.packages = with pkgs; [
      papirus-icon-theme
      # or tela-icon-theme, gruvbox-plus-icons
    ];

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus"; # Or "Tela", "Gruvbox-Plus-Dark"
        package = pkgs.papirus-icon-theme;
      };
    };
  #};
}
{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./easyeffects.nix
      ./loupe.nix
      ./spicetify.nix
      ./vesktop.nix
      ./yubikey.nix
      ./zen.nix
      ./brave.nix
      ./vscode.nix
      ./nextcloud.nix
      ./bitwarden.nix
      ./obsidian.nix
      ./gui_utilities.nix
    ];
}

{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./gui/zen.nix
      ./gui/bitwarden.nix
      ./gui/rofi.nix
      ./gui/dolphin.nix
      ./cli/kitty.nix
    ];
}

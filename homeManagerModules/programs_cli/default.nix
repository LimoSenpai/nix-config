{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./foot.nix
      ./wezterm.nix
      ./power-profiles-daemon.nix
      ./playerctl.nix
      ./programs_cli.nix
    ];
}

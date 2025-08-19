{config, pkgs, ... }:

{
  imports =
    [
      ./programs_work.nix
      ./standard_selection.nix
      ./element.nix
    ];
}

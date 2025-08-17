{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.zen-browser
  ];
}

{ pkgs, lib, config, ... }:
{
  options.foot.enable = lib.mkEnableOption "Foot terminal";

  config = lib.mkIf config.foot.enable {
    programs.foot = {
      enable = true;
      settings.scrollback.lines = 100000;
    };
  };
}

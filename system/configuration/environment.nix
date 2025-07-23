
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    nano
    wget
    pavucontrol
    neovim
    # Cursor theme
    rose-pine-hyprcursor
  ];
  

  environment.variables = {
    EDITOR = "nano";
    XCURSOR_THEME = "BreezeX-RosePine";
    XCURSOR_SIZE = 26;
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = 26;
  };
  
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      ''; # or just "zen" if you use unwrapped package
      mode = "0755";
    };
  };
}
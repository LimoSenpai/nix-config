{ pkgs }:
with pkgs;
{
  # System Tools (requiring system-level access)
  nwg-displays       = nwg-displays;
  way-displays       = way-displays;
  hyprlock           = hyprlock;
  
  # File Management (system-level)
  ark                = file-roller;
  
  # AMD Tools (requiring system access)
  mesa-demos         = mesa-demos;
  radeon-profile     = radeon-profile;
  
  # System Audio
  pavucontrol        = pavucontrol;
  pulseaudio         = pulseaudio;
}

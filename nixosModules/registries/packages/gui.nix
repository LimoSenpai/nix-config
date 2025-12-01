{ pkgs }:
with pkgs;
{
  # System Tools (requiring system-level access)
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

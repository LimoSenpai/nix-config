{ conifg, pkgs, lib, ... }:
{
  fonts = {
    enableDefaultPackages = true;  # optional

    packages = with pkgs; [
      noto-fonts
    ] ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts));

    fontconfig = {
      antialias = true;                # Smooth font edges (on by default, but ensure true)
      hinting.enable = true;           # Enable font hinting for better alignment
      hinting.style = "slight";        # Hinting level: "slight" (keep shapes, slight crisping)
      # hinting.style = "full";        # (Alternatively, "full" for maximum crispness if preferred)
      subpixel.rgba = "rgb";           # Subpixel order for LCD (MacBook is standard RGB):contentReference[oaicite:2]{index=2}
      subpixel.lcdfilter = "default";  # Use default LCD filter for subpixel rendering
  };
  };
}
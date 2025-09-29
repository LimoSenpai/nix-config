{
  lib,
  stdenv,
  sddm-astronaut
}:

stdenv.mkDerivation {
  pname = "sddm-astronaut-hyprland_kath";
  version = "1.0.0";

  src = sddm-astronaut.src;

  dontBuild = true;
  dontConfigure = true;

  unpackPhase = ''
    cp -r ${sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme .
  '';

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r sddm-astronaut-theme $out/share/sddm/themes/astronaut
    chmod -R +w $out/share/sddm/themes/astronaut
    substituteInPlace $out/share/sddm/themes/astronaut/metadata.desktop \
      --replace 'ConfigFile=Themes/astronaut.conf' 'ConfigFile=Themes/hyprland_kath.conf'
  '';

  meta = with lib; {
    description = "Modified Astronaut theme for SDDM with Hyprland configuration";
    platforms = platforms.linux;
    inherit (sddm-astronaut.meta) license;
  };
}

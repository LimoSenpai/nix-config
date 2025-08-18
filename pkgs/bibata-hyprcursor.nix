{ lib, stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation rec {
  pname = "bibata-hyprcursor";
  version = "1.0";

  src = fetchurl {
    url = "https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor/releases/download/${version}/hypr_Bibata-Modern-Classic.tar.gz";
    sha256 = "sha256-+ZXnbI3bBLcb0nv2YW3eM/tK4dsraNM4UAO9BpSqfXk=";
  };

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share/icons/Bibata-Modern-Classic
    cp -r * $out/share/icons/Bibata-Modern-Classic/
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Bibata Modern Classic cursor theme for Hyprland (hyprcursor format)";
    homepage = "https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}

{ lib, stdenvNoCC, bash, xcursorgen, icoutils, imagemagick }:

let
  pointErWindows = ../assets/sources/point-er/windows;
  converterScript = ../assets/scripts/point-er-to-xcursor.sh;
in
stdenvNoCC.mkDerivation rec {
  pname = "point-er-cursors";
  version = "1.0";

  src = null;

  nativeBuildInputs = [ bash xcursorgen icoutils imagemagick ];

  dontUnpack = true;

  buildPhase = ''
    runHook preBuild

    mkdir -p build
    bash ${converterScript} ${pointErWindows} build 35

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -r build/* $out/share/icons/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Point.er cursor themes converted to Xcursor";
    homepage = "https://vsthemes.org";
    license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
    maintainers = [];
  };
}

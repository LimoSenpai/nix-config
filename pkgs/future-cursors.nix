{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "future-cursors";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "yeyushengfan258";
    repo = "Future-cursors";
    rev = "587c14d2f5bd2dc34095a4efbb1a729eb72a1d36";
    sha256 = "sha256-ziEgMasNVhfzqeURjYJK1l5BeIHk8GK6C4ONHQR7FyY=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share/icons/Future-Cursors
    cp -r dist/* $out/share/icons/Future-Cursors/
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Future cursors for linux desktops - an x-cursor theme inspired by macOS";
    homepage = "https://github.com/yeyushengfan258/Future-cursors";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}

{ pkgs, lib, fetchurl, appimageTools }:

let
  pname = "mediaharbor";
  version = "1.1.0";
  
  src = fetchurl {
    url = "https://github.com/MediaHarbor/mediaharbor/releases/download/v${version}/MediaHarbor-${version}.AppImage";
    sha256 = "0r6rwvq3nzp7gms5qsk0rbbwnb7ljagp8ffc0sa7agsyyfywapgc";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
  
  extraPkgs = pkgs: with pkgs; [
    # Media libraries
    ffmpeg_7-full
    
    # Video playback
    libva
    libva-utils
    libvdpau
    
    # Codecs
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];
  
  extraInstallCommands = 
    let
      appimageContents = appimageTools.extractType2 { inherit pname version src; };
    in
    ''
      # Create desktop entry
      install -m 444 -D ${appimageContents}/mediaharbor.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/mediaharbor.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${appimageContents}/usr/share/icons $out/share
    '';
  
  meta = with lib; {
    description = "MediaHarbor - A unified media management application";
    homepage = "https://mediaharbor.github.io/";
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
  };
}

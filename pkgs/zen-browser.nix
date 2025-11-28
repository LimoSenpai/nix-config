{ pkgs, lib, fetchurl, appimageTools }:

let
  pname = "zen-browser";
  version = "1.17.10b";
  
  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-x86_64.AppImage";
    sha256 = "sha256-J67s+P8ubeGYgXqf8z/fl3KOyrBTEpK/b9pQoONkC6Q=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
  
  extraPkgs = pkgs: with pkgs; [
    # Video acceleration
    libva
    libva-utils
    libvdpau
    libva-vdpau-driver
    
    # Media codecs
    ffmpeg_7-full
    linphonePackages.mediastreamer2
    openh264
    linphonePackages.msopenh264
    
    # Additional codec libraries
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];
  
  extraInstallCommands = ''
    # Create a wrapper script that sets environment variables
    mv $out/bin/${pname} $out/bin/.${pname}-wrapped
    cat > $out/bin/${pname} << EOF
    #!/bin/sh
    export MOZ_ENABLE_WAYLAND=1
    export LIBVA_DRIVER_NAME=nvidia
    exec $out/bin/.${pname}-wrapped "\$@"
    EOF
        chmod +x $out/bin/${pname}
  '';
  
  meta = with lib; {
    description = "Zen Browser - A Firefox-based browser";
    homepage = "https://zen-browser.app";
    license = licenses.mpl20;
    platforms = [ "x86_64-linux" ];
  };
}

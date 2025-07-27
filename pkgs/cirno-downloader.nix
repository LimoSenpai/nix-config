{ stdenv, lib, makeWrapper, patchelf
, glibc, openssl, webkitgtk_4_1
, gtk3, cairo, gdk-pixbuf, libsoup_3, glib
, gst_all_1, fdk_aac, glib-networking, gsettings-desktop-schemas
, libjpeg, librsvg, libpng, libwebp, gdk-pixbuf-xlib, ... }:

stdenv.mkDerivation {
  pname = "cirno-downloader";
  version = "1.0";

  src = ../assets/bin/cirno-downloader;

  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper patchelf glib.dev ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src ./cirno-downloader-patched
    chmod +w ./cirno-downloader-patched

    patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) \
      --set-rpath ${lib.makeLibraryPath [
        glibc openssl webkitgtk_4_1 gtk3 cairo gdk-pixbuf gdk-pixbuf-xlib
        libsoup_3 glib glib-networking gsettings-desktop-schemas
        gst_all_1.gstreamer gst_all_1.gst-plugins-base gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad gst_all_1.gst-plugins-ugly gst_all_1.gst-libav
        fdk_aac libjpeg librsvg libpng libwebp
      ]} \
      ./cirno-downloader-patched

    mv ./cirno-downloader-patched $out/bin/cirno-downloader

    mkdir -p $out/share/glib-2.0/schemas

    mkdir -p $out/share/glib-2.0/schemas
    cp ${gtk3}/share/gsettings-schemas/gtk+3-3.24.49/glib-2.0/schemas/*.gschema.xml $out/share/glib-2.0/schemas/
    glib-compile-schemas $out/share/glib-2.0/schemas

    glib-compile-schemas $out/share/glib-2.0/schemas

    wrapProgram $out/bin/cirno-downloader \
      --set WEBKIT_DISABLE_COMPOSITING_MODE 1 \
      --set GDK_BACKEND x11 \
      --set GIO_USE_VFS local \
      --set GIO_EXTRA_MODULES ${lib.makeLibraryPath [ glib-networking ]} \
      --set XDG_DATA_DIRS "$out/share:$XDG_DATA_DIRS"
  '';

  meta = {
    description = "Cirno Downloader (binary only)";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.unfree;
  };
}

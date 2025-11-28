{ config, lib, pkgs, ... }:

{
  options.zen-browser = {
    enable = lib.mkEnableOption "Zen Browser with hardware acceleration";
  };

  config = lib.mkIf config.zen-browser.enable {
    home.file.".zen/chrome/user.js".text = ''
      // Enable hardware video decoding
      user_pref("media.ffmpeg.vaapi.enabled", true);
      user_pref("media.rdd-ffmpeg.enabled", true);
      user_pref("media.navigator.mediadatadecoder_vpx_enabled", true);
      
      // Enable AV1 codec
      user_pref("media.av1.enabled", true);
      
      // Disable software fallback to force hardware decoding
      user_pref("media.ffvpx.enabled", false);
      
      // Enable WebRender and hardware acceleration
      user_pref("gfx.webrender.all", true);
      user_pref("layers.acceleration.force-enabled", true);
      user_pref("media.hardware-video-decoding.enabled", true);
      user_pref("media.hardware-video-decoding.force-enabled", true);
      
      // NVIDIA VA-API specific
      user_pref("media.ffmpeg.dmabuf-textures.enabled", true);
      
      // Additional codec support
      user_pref("media.mediasource.enabled", true);
      user_pref("media.mediasource.mp4.enabled", true);
      user_pref("media.mediasource.webm.enabled", true);
    '';
  };
}

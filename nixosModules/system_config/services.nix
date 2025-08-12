
{ config, lib, pkgs, ... }: {

  systemd.user.services.lxqt-policykit = {
    description = "PolicyKit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/libexec/lxqt-policykit-agent";
      Restart = "on-failure";
    };
  };


  # services

  #services.netbird = {
  #  enable = true;
  #};
  #environment.systemPackages = [ pkgs.netbird-ui ];


  services.udev.extraRules = ''
    # SteelSeries Aerox 9 Wireless — Allow USB and hidraw access
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1038", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="1038", MODE="0666"
    SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="low"
  '';

  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.blueman.enable = true;
  services.dbus.packages = [ 
    pkgs.blueman 
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };
}

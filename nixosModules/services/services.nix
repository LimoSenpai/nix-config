
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

  #for yubikey
  services.pcscd.enable = true;

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

  services.lact.enable = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PubkeyAuthentication = true;
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  security.sudo.enable = true;

  # Allow 'tinus' to power off without a password | FOR HOME ASSISTANT REMOTE SHUTDOWN
  security.sudo.extraRules = [
    {
      users = [ "tinus" ];
      commands = [{
        command = "/run/current-system/sw/bin/systemctl poweroff";
        options = [ "NOPASSWD" ];
      }];
    }
  ];
}

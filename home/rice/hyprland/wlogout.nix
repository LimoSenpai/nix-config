{ inputs, pkgs, lib, ... }:
let
  iconFiles = builtins.readDir ../../../assets/icons/wlogout;

  iconSymlinks = builtins.foldl'
    (acc: name:
      acc // {
        ".config/wlogout/icons/${name}".source = ../../../assets/icons/wlogout + "/${name}";
      }
    )
    { } (builtins.attrNames iconFiles);
in
{
  home.file = {
    ".config/wlogout/layout.json".text = ''
        {
            "label" : "lock",
            "action" : "swaylock",
            "text" : "Lock",
            "keybind" : "l",
            "icon" : "lock.svg"
        }
        {
            "label" : "hibernate",
            "action" : "systemctl hibernate",
            "text" : "Hibernate",
            "keybind" : "h",
            "icon" : "hibernate.svg"
        }
        {
            "label" : "logout",
            "action" : "loginctl terminate-user $USER",
            "text" : "Logout",
            "keybind" : "e",
            "icon" : "logout.svg"
        }
        {
            "label" : "shutdown",
            "action" : "systemctl poweroff",
            "text" : "Shutdown",
            "keybind" : "s",
            "icon" : "shutdown.svg"
        }
        {
            "label" : "suspend",
            "action" : "systemctl suspend",
            "text" : "Suspend",
            "keybind" : "u",
            "icon" : "suspend.svg"
        }
        {
            "label" : "reboot",
            "action" : "systemctl reboot",
            "text" : "Reboot",
            "keybind" : "r",
            "icon" : "reboot.svg"
        }
    '';

    ".config/wlogout/style.css".text = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(30, 30, 46, 0.90);
      }

      button {
        border-radius: 0;
        border-color: #b4befe;
        text-decoration-color: #cdd6f4;
        color: #cdd6f4;
        background-color: #181825;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        /* 20% Overlay 2, 80% mantle */
        background-color: rgb(48, 50, 66);
        outline-style: none;
      }

      #lock {
          background-image: url("/home/tinus/.config/wlogout/icons/lock.svg");
      }

      #logout {
          background-image: url("/home/tinus/.config/wlogout/icons/logout.svg");
      }

      #suspend {
          background-image: url("/home/tinus/.config/wlogout/icons/suspend.svg");
      }

      #hibernate {
          background-image: url("/home/tinus/.config/wlogout/icons/hibernate.svg");
      }

      #shutdown {
          background-image: url("/home/tinus/.config/wlogout/icons/shutdown.svg");
      }

      #reboot {
          background-image: url("/home/tinus/.config/wlogout/icons/reboot.svg");
      }
    '';
  } // iconSymlinks;
}

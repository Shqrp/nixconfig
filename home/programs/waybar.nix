{
  inputs,
  displays,
  getDisplay,
  system,
  ...
}:

{
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${system}.waybar;
    systemd.enable = true;

    settings =
      if builtins.length displays == 2 then
        [
          {
            output = (getDisplay 1).id;
            height = 24;
            spacing = 4;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [
              "load"
              "clock"
              "tray"
            ];

            tray = {
              icon-size = 14;
              spacing = 10;
            };
            load = {
              interval = 2;
              format = "load: {load1} {load5} {load15}";
            };
            clock = {
              interval = 1;
              timezone = "Europe/Rome";
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
              format = "{:%H:%M:%S, %Y/%m/%d}";
            };

            "hyprland/window".separate-outputs = true;
          }
          {
            output = (getDisplay 0).id;
            height = 24;
            spacing = 4;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [
              "mpris"
              "wireplumber"
            ];

            mpris = {
              format = " {status_icon} {dynamic}";
              interval = 1;
              dynamic-len = 40;
              status-icons = {
                playing = "▶";
                paused = "⏸";
                stopped = "";
              };
              dynamic-order = [
                "title"
                "artist"
              ];
            };

            wireplumber = {
              scroll-step = 5;
              format = "{icon} {volume}%";
              format-bluetooth = "{icon} {volume}% ";
              format-bluetooth-muted = " {icon}";
              format-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                  ""
                ];
              };
              on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };

            "hyprland/window".separate-outputs = true;
          }
        ]
      else
        [
          {
            output = (getDisplay 1).id;
            height = 24;
            spacing = 4;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [
              "mpris"
              "clock"
              "wireplumber"
              "battery"
              "tray"
            ];

            tray = {
              icon-size = 14;
              spacing = 10;
            };
            battery = {
              interval = 1;
              format = "{icon} {capacity}% - {power:4.1f} W";
              format-charging = "󱐋{icon} {capacity}% - {power:4.1f} W";
              format-icons = [
                "󰂎"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            mpris = {
              format = " {status_icon} {dynamic}";
              interval = 1;
              dynamic-len = 40;
              status-icons = {
                playing = "▶";
                paused = "⏸";
                stopped = "";
              };
              dynamic-order = [
                "title"
                "artist"
              ];
            };
            wireplumber = {
              scroll-step = 5;
              format = "{icon} {volume}%";
              format-bluetooth = "{icon} {volume}% ";
              format-bluetooth-muted = " {icon}";
              format-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                  ""
                ];
              };
              on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };
            clock = {
              interval = 1;
              timezone = "Europe/Rome";
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
              format = "{:%H:%M:%S, %Y/%m/%d}";
            };

            "hyprland/window".separate-outputs = true;
          }
        ];

    style = ''
      * {
        font-size: 16px;
        border-radius: 6px;
      }

      @keyframes blink {
        to {
          background-color: #2e3440;
          color: #e5e9f0;
        }
      }

      window#waybar {
        font-family: "JetBrains Mono Nerd Font", monospace;
        border-bottom: 0px;
        color: #e5e9f0;
        background-color: transparent;
        transition-property: background-color;
        transition-duration: .5s;
      }
      window#waybar.hidden {
        opacity: 0.2;
      }
      window#waybar.empty #window {
        background-color: transparent;
      }

      .modules-right {
        margin: 10px 10px 0 0;
      }
      .modules-center {
        margin: 10px 0 0 0;
      }
      .modules-left {
        margin: 10px 0 0 10px;
      }
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      button {
        border: none;
      }
      button:hover {
        background: inherit;
      }

      #workspaces {
        background-color: #2e3440;
      }

      #workspaces button {
        padding: 0 5px;
        color: #e5e9f0;
        border-radius: 0;
      }
      #workspaces button:first-child {
        border-radius: 5px 0 0 5px;
      }
      #workspaces button:last-child {
        border-radius: 0 5px 5px 0;
      }
      #workspaces button:only-child {
        border-radius: 5px 5px 5px 5px;
      }
      #workspaces button:hover {
        background-color: #81a1c1;
        color: #3b4252;
        box-shadow: inherit;
        text-shadow: inherit;
      }
      #workspaces button.focused {
        background-color: #3b4252;
      }
      #workspaces button.urgent {
        background-color: #b48ead;
      }

      #idle_inhibitor,
      #cava,
      #scratchpad,
      #mode,
      #window,
      #clock,
      #battery,
      #backlight,
      #wireplumber,
      #tray,
      #mpris,
      #load {
        padding: 0 10px;
        background-color: #2e3440;
        color: #e5e9f0;
      }

      #cava {
        padding: 0 5px;
      }
      #mode {
        background-color: #8fbcbb;
        color: #2e3440;
      }

      #battery.charging, #battery.plugged {
        background-color: #ebcb8b;
        color: #2e3440;
      }
      #battery.critical:not(.charging) {
        background-color: #bf616a;
        color: #e5e9f0;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #wireplumber.muted {
        padding: 0 19px 0 10px;
        background-color: #81a1c1;
        color: #3b4252;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #mpris.playing {
        background-color: #81a1c1;
        color: #2e3440;
      }

      #tray menu {
        font-family: sans-serif;
      }

      #scratchpad.empty {
        background: transparent;
      }
    '';
  };
}

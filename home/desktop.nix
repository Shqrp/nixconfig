{
  inputs,
  pkgs,
  lib,
  displayConfig,
  hostname,
  system,
  getDisplay,
  ...
}:

{
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    WLR_NO_HARDWARE_CURSORS = "1";
  }
  // lib.attrsets.optionalAttrs (hostname == "ryzenix" || hostname == "rognix") {
    PROTON_ENABLE_NGX_UPDATER = "1";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # wayland.windowManager.mango = {
  #   enable = true;
  #   systemd = {
  #     enable = true;
  #     xdgAutostart = true;
  #   };
  #
  #   settings =
  #     let
  #       display0 = getDisplay 0;
  #       display1 = getDisplay 1;
  #     in
  #     ''
  #       exec-once=${pkgs.wlr-randr}/bin/wlr-randr --output Unknown-1 --off"
  #       exec-once=${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit
  #       exec-once=${pkgs.xfce.thunar}/bin/thunar --daemon
  #
  #       monitorrule=name:${display0.id}
  #
  #       bind=SUPER,f,killclient
  #       bind=SUPER,m,quit
  #       bind=SUPER,z,togglefloating
  #       bind=SUPER,x,togglefullscreen
  #
  #       bind=SUPER,s,spawn,alacritty
  #       bind=SUPER,a,spawn,thunar
  #       bind=SUPER+SHIFT,s,spawn,grim -g "$(slurp)" "/home/shqrp/Screenshots/$(date +%Y-%m-%d %R:%S).png"
  #       bind=SUPER,d,spawn,tofi-drun --drun-launch=false | zsh
  #       bind=SUPER,c,spawn,hyprpicker -a
  #
  #       bind=SUPER,left,focusdir,left
  #       bind=SUPER,right,focusdir,right
  #       bind=SUPER,up,focusdir,up
  #       bind=SUPER,down,focusdir,down
  #       bind=SUPER+SHIFT,left,exchange_client,left
  #       bind=SUPER+SHIFT,right,exchange_client,right
  #       bind=SUPER+SHIFT,up,exchange_client,up
  #       bind=SUPER+SHIFT,down,exchange_client,down
  #
  #       bind=SUPER,1,view,1
  #       bind=SUPER,2,view,2
  #       bind=SUPER,3,view,3
  #       bind=SUPER,4,view,4
  #       bind=SUPER,q,view,5
  #       bind=SUPER,w,view,6
  #       bind=SUPER,e,view,7
  #       bind=SUPER,r,view,8
  #       bind=SUPER,code:49,view,9
  #       bind=SUPER+SHIFT,1,tag,1
  #       bind=SUPER+SHIFT,2,tag,2
  #       bind=SUPER+SHIFT,3,tag,3
  #       bind=SUPER+SHIFT,4,tag,4
  #       bind=SUPER+SHIFT,q,tag,5
  #       bind=SUPER+SHIFT,w,tag,6
  #       bind=SUPER+SHIFT,e,tag,7
  #       bind=SUPER+SHIFT,r,tag,8
  #       bind=SUPER+SHIFT,code:49,tag,9
  #       bind=SUPER,code:112,viewtoleft
  #       bind=SUPER,code:117,viewtoright
  #       mousebind=SUPER,btn_left,movewin,curmove
  #       mousebind=SUPER,btn_right,resizewin,curresize
  #
  #       bindl=NONE,XF86MonBrightnessUp,spawn,${pkgs.brightnessctl}/bin/brightnessctl set +5%
  #       bindl=NONE,XF86MonBrightnessDown,spawn,${pkgs.brightnessctl}/bin/brightnessctl set -5%
  #       bindl=NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ +5%
  #       bindl=NONE,XF86AudioLowerVolume,spawn,wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%-
  #       bindl=NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  #       bindl=NONE,XF86AudioPlay,spawn,playerctl play-pause
  #       bindl=NONE,XF86AudioNext,spawn,playerctl next
  #       bindl=NONE,XF86AudioPrevious,spawn,playerctl previous
  #
  #
  #
  #     '';
  # };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    settings = {
      monitor = displayConfig;
      env = [
        "GDK_BACKEND,wayland,x11"
        "SDL_VIDEODRIVER,wayland,x11"
        "CLUTTER_BACKEND,wayland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "WLR_NO_HARDWARE_CURSORS,1"
        "PROTON_ENABLE_NGX_UPDATER,1"
      ]
      ++ lib.optional (hostname == "ryzenix" || hostname == "rognix") [
        "__NV_PRIME_RENDER_OFFLOAD,1"
        "__VK_LAYER_NV_optimus,NVIDIA_only"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "LIBVA_DRIVER_NAME,nvidia"
        "NVD_BACKEND,direct"
      ];

      exec-once = [
        "${pkgs.wlr-randr}/bin/wlr-randr --output Unknown-1 --off" # disables weird Unknown-1 display
        "${
          inputs.hyprpolkitagent.packages.${system}.default
        }/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit"
        "hyprctl setcursor graphite-light-nord 24"
        "${pkgs.xfce.thunar}/bin/thunar --daemon"
        "${pkgs.localsend}/bin/localsend_app --hidden"
        # "${pkgs.dex}/bin/dex -a"
      ];

      input.kb_layout = "it";
      device = {
        name = "tpps/2-elan-trackpoint";
        disable_while_typing = true;
      };

      general = {
        border_size = 2;
        "col.active_border" = "rgb(d8dee9) rgb(eceff4) 45deg";
        "col.inactive_border" = "rgb(4c566a)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          passes = 1;
        };
        shadow = {
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      layerrule = [
        "blur on, match:class launcher"
        "blur off, match:class bottom"
      ];

      # device = {
      #   name = "epic-mouse-v1";
      #   sensitivity = -0.5;
      # };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, S, exec, alacritty"
        "$mainMod, A, exec, thunar"
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" \"/home/shqrp/Screenshots/$(date +%Y-%m-%d\\ %R:%S).png\""

        "$mainMod, Q, killactive"
        "$mainMod, M, exit,"
        "$mainMod, Z, togglefloating,"
        "$mainMod, D, exec, tofi-drun --drun-launch=false | zsh"
        "$mainMod, P, pseudo,"
        "$mainMod, J, layoutmsg, togglesplit,"
        "$mainMod, C, exec, hyprpicker -a"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrevious, exec, playerctl previous"
      ];
    };
  };
}

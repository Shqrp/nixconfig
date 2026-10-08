{
  inputs,
  pkgs,
  lib,
  displays,
  hostname,
  system,
  ...
}:

{
  gtk = {
    enable = true;
    gtk4.theme = null;
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
    configType = "lua";

    settings = {
      monitor = map (d: {
        output = d.id;
        mode = "${d.width}x${d.height}@60";
        position = d.offset;
        scale = 1;
      }) displays;

      env = map (kv: { _args = kv; }) [
        [ "GDK_BACKEND" "wayland,x11" ]
        [ "SDL_VIDEODRIVER" "wayland,x11" ]
        [ "CLUTTER_BACKEND" "wayland" ]
        [ "QT_QPA_PLATFORM" "wayland;xcb" ]
        [ "WLR_NO_HARDWARE_CURSORS" "1" ]
        [ "PROTON_ENABLE_NGX_UPDATER" "1" ]
      ] ++ lib.lists.optionals (hostname == "ryzenix" || hostname == "rognix") [
        [ "__NV_PRIME_RENDER_OFFLOAD" "1" ]
        [ "__VK_LAYER_NV_optimus" "NVIDIA_only" ]
        [ "__GLX_VENDOR_LIBRARY_NAME" "nvidia" ]
        [ "GBM_BACKEND" "nvidia-drm" ]
        [ "LIBVA_DRIVER_NAME" "nvidia" ]
        [ "NVD_BACKEND" "direct" ]
      ];

      device = {
        name = "tpps/2-elan-trackpoint";
        disable_while_typing = true;
      };

      curve = {
        _args = [
          "bez"
          {
            type = "bezier";
            points = [
              [
                0.05
                0.9
              ]
              [
                0.1
                1.05
              ]
            ];
          }
        ];
      };
      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 7;
          bezier = "bez";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 7;
          bezier = "bez";
          style = "popin 80%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "bez";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "bez";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 7;
          bezier = "bez";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 6;
          bezier = "bez";
        }
      ];

      config = {
        input.kb_layout = "it";

        general = {
          border_size = 2;
          col = {
            active_border = {
              colors = [
                "#d8dee9"
                "#eceff4"
              ];
              angle = 45;
            };
            inactive_border = "#4c566a";
          };
        };

        decoration = {
          rounding = 10;
          blur = {
            passes = 10;
            # variant = "acrylic";
            size = 16;
          };
          shadow.color = "#1a1a1aee";
        };

        dwindle.smart_split = true;

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          disable_watchdog_warning = true;
          force_default_wallpaper = 0;
        };

        layer_rule = [
          {
            match.class = "launcher";
            blur = true;
          }
          {
            match.class = "bottom";
            blur = false;
          }
        ];
      };
    };
    extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("${pkgs.wlr-randr}/bin/wlr-randr --output Unknown-1 --off")
        hl.exec_cmd("${
          inputs.hypr.packages.${system}.hyprpolkitagent
        }/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit")
        hl.exec_cmd("hyprctl setcursor graphite-light-nord 24")
        hl.exec_cmd("${pkgs.thunar}/bin/thunar --daemon")
        hl.exec_cmd("${pkgs.localsend}/bin/localsend_app --hidden")
        hl.exec_cmd("${pkgs.librepods}/bin/librepods --hide")
      end)

      hl.bind("SUPER + S", hl.dsp.exec_cmd("alacritty"))
      hl.bind("SUPER + A", hl.dsp.exec_cmd("thunar"))
      hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" \"/home/shqrp/Screenshots/$(date +%Y-%m-%d\\ %R:%S).png\""))

      hl.bind("SUPER + Q", hl.dsp.window.kill())
      hl.bind("SUPER + M", hl.dsp.exit())
      hl.bind("SUPER + Z", hl.dsp.window.float({ action = "toggle" }))
      hl.bind("SUPER + D", hl.dsp.exec_cmd("tofi-drun --drun-launch=false | zsh"))
      hl.bind("SUPER + P", hl.dsp.window.pseudo())
      hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
      hl.bind("SUPER + C", hl.dsp.exec_cmd("hyprpicker -a"))

      hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
      hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
      hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
      hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

      for i = 1, 9 do
        hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
        hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
      end
      hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))
      hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

      hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl set +5%"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl set 5%-"), { locked = true, repeating = true })

      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
    '';
  };
}

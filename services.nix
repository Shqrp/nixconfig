{ pkgs, getDisplay, lib, ... }:

{
  # Authentication stuff
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      session.default = "Hyprland";
      user.default = "shqrp";
      appearance = {
        font_family = "JetBrains Mond Nerd Font";
        scheme = "Nord";
        theme_mode = "dark";
        hide_logo = true;
      };
      output = {
        name = (getDisplay 0).id;
        width = (getDisplay 0).width;
        height = (getDisplay 0).height;
      };
      cursor = {
        theme = "graphite-light-nord";
        size = 32;
        path = "${pkgs.graphite-cursors}/share/icons";
      };
      keyboard.layout = "it";
      auth = {
        allow_empty_password = true;
        request_timeout = 10;
      };
    };
  };
  # security.polkit.enable = true;
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = ''${pkgs.tuigreet}/bin/tuigreet --time --cmd "start-hyprland 2>&1 > /dev/null"'';
  #       user = "greeter";
  #     };
  #   };
  # };
  # systemd.services.greetd.serviceConfig = {
  #   Type = "idle";
  #   StandardInput = "tty";
  #   StandardOutput = "tty";
  #   StandardError = "journal";
  #   TTYReset = true;
  #   TTYHangup = true;
  #   TTYVTDisallocate = true;
  # };

  services.printing = {
    enable = true;
    startWhenNeeded = true;
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
      domain = true;
    };
  };

  services.fwupd.enable = true;

  # Audio configuration
  # sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;

  services.blueman.enable = true;

  services.tailscale.enable = true;
  systemd.services.tailscaled.wantedBy = lib.mkForce [ "greetd.service" ];
  systemd.services.NetworkManager.wantedBy = lib.mkForce [ "greetd.service" ];

  xdg.portal.enable = true;
  services.flatpak.enable = true;
}

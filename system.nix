{
  inputs,
  hostname,
  pkgs,
  pkgs-unstable,
  system,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    supportedFilesystems = [
      "exfat"
      "ntfs"
    ];

    loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
      consoleMode = "0";
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
  };

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";

  i18n.extraLocaleSettings = {
    LANG = "en_US.UTF-8";
    LANGUAGE = "en_US.UTF-8";
    LC_CTYPE = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_ADDRESS = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "it";
  };

  programs.dconf.enable = true;
  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      hyprland.default = [
        "hyprland"
        "gtk"
      ];
    };
    configPackages = [
      pkgs-unstable.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld.packages.${system}.nix-ld;
  };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
    package = inputs.opentabletdriver.packages.${system}.default;
  };

  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
  programs.virt-manager.enable = true;

  system.stateVersion = "23.11";
}

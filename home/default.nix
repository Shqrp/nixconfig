{
  pkgs,
  inputs,
  system,
  hostname,
  displays,
  ...
}:

{
  users.users.shqrp = {
    isNormalUser = true;
    home = "/home/shqrp";
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
    ];
    description = "Andrea Giurgola";
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  home-manager = {
    sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
    useGlobalPkgs = true;

    users.shqrp = {
      home = {
        username = "shqrp";
        homeDirectory = "/home/shqrp";
        stateVersion = "24.05";

        sessionVariables = {
          NIXOS_OZONE_WL = 1;
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
        };

        pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.graphite-cursors;
          name = "graphite-light-nord";
        };

        packages = with pkgs; [
          # Utilities
          hyprpicker
          nixfmt-rfc-style
          sops

          # Libraries and backends
          nixd
          xfce.thunar-volman

          # Developer stuff
          deno
          nodejs_22
          rustup
          gcc
          mongodb-compass

          # Desktop applications
          spotify-qt
          firefox
          xfce.thunar

          kdePackages.breeze-icons
        ];
      };

      imports = [
        ./programs
        ./services
        ./desktop.nix
        ./sops.nix
      ];
    };

    extraSpecialArgs =
      let
        getDisplay = index: builtins.elemAt displays index;
      in
      {
        inherit inputs;
        inherit system;
        inherit hostname;
        inherit displays;
        inherit getDisplay;
      };
  };
}

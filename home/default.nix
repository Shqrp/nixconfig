{
  pkgs,
  pkgs-unstable,
  inputs,
  system,
  hostname,
  displays,
  displayConfig,
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
      "docker"
    ];
    description = "Andrea Giurgola";
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  home-manager = {
    sharedModules = [
      inputs.nvf.homeManagerModules.default
      inputs.sops-nix.homeManagerModules.sops
    ];
    useGlobalPkgs = true;

    users.shqrp = {
      xdg.autostart.enable = true;
      xdg.autostart.entries = [
        "${pkgs-unstable.librepods}/share/applications/me.kavishdevar.librepods.desktop"
      ];
      home = {
        username = "shqrp";
        homeDirectory = "/home/shqrp";
        stateVersion = "24.05";

        sessionVariables = {
          NIXOS_OZONE_WL = 1;
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
          SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
        };

        pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.graphite-cursors;
          name = "graphite-light-nord";
        };

        packages =
          with pkgs;
          [
            # Utilities
            hyprpicker
            nixfmt-rfc-style
            sops
            grim
            slurp
            ripgrep
            fd
            unzip
            freerdp
            pkgs-unstable.librepods

            # Libraries and backends
            xfce.thunar-volman
            tree-sitter

            # Developer stuff
            deno
            nodejs_22
            pnpm
            rustup
            gcc
            mongodb-compass
            nixd
            libclang
            insomnia
            neovide
            (pkgs-unstable.typst.withPackages (
              ps: with ps; [
                itemize
                theorion
                cetz
                cetz-plot
              ]
            ))
            typstyle

            # Desktop applications
            firefox
            xfce.thunar
            obsidian
            pkgs-unstable.osu-lazer-bin
            qbittorrent
            celluloid
            anki-bin
            (mathematica.override {
              source = ../bin/Wolfram_14.3.0_LIN_Bndl.sh;
              version = "14.3.0";
            })

            kdePackages.breeze-icons
          ]
          ++ lib.optionals (hostname == "nixpad") [
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
        inherit displayConfig;
        inherit pkgs-unstable;
      };
  };
}

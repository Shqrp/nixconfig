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
      inputs.mangowm.hmModules.mango
      inputs.nvf.homeManagerModules.default
      inputs.sops-nix.homeManagerModules.sops
    ];
    useGlobalPkgs = true;

    users.shqrp = {
      xdg.autostart.enable = false;
      xdg.autostart.entries = [];
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
            inputs.hypr.packages.${system}.hyprpicker
            nixfmt
            sops
            grim
            slurp
            ripgrep
            fd
            unzip
            freerdp
            pkgs-unstable.librepods
            moodle-dl
            localsend

            # Libraries and backends
            thunar-volman
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
                zero
              ]
            ))
            typstyle

            # Desktop applications
            firefox
            inputs.zen-browser.packages.${system}.default
            thunar
            obsidian
            pkgs-unstable.osu-lazer-bin
            qbittorrent
            celluloid
            anki-bin
            (mathematica.override {
              source = ../bin/Wolfram_15.0.1.sh;
              versionInfo = {
                version = "15.0.1";
                lang = "en";
                language = "English";
                hash = "sha256-VzK8CuOhk4sOO5CL4z3rfpY5631F2RN6c0Dh8cExeeg=";
                installer = "Wolfram_15.0.1.sh";
              };
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

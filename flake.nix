{
  description = "shqrp's nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-ld.url = "github:nix-community/nix-ld";

    hypridle.url = "github:hyprwm/hypridle";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpaper.url = "github:hyprwm/hyprpaper";

    opentabletdriver.url = "github:OpenTabletDriver/opentabletdriver";
  };

  outputs =
    { home-manager, ... }@inputs:
    let
      lib = import ./lib.nix {
        inherit inputs;
        inherit home-manager;
      };
    in
    {
      nixosConfigurations = {
        ryzenix = lib.mkHost {
          hostname = "ryzenix";
          displays = [
            {
              id = "HDMI-A-1";
              width = "1920";
              height = "1080";
            }
            {
              id = "DP-1";
              width = "1920";
              height = "1200";
            }
          ];
        };
        rognix = lib.mkHost {
          hostname = "rognix";
          displays = [
            {
              id = "eDP-1";
              width = "1920";
              height = "1080";
            }
          ];
        };
        nixpad = lib.mkHost {
          hostname = "nixpad";
          displays = [
            {
              id = "eDP-1";
              width = "1920";
              height = "1200";
            }
          ];
        };
      };
    };
}

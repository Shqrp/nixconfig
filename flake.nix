{
  description = "shqrp's nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:nix-community/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle.url = "github:hyprwm/hypridle";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpaper.url = "github:hyprwm/hyprpaper";

    opentabletdriver = {
      url = "github:OpenTabletDriver/opentabletdriver";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
      };
    };
}

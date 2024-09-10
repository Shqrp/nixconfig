{
  description = "shqrp's nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # waybar = {
    #   url = "github:Alexays/Waybar";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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

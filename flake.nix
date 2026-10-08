{
  description = "shqrp's nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-ld.url = "github:nix-community/nix-ld";

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr.url = "github:hyprwm/hyprnix";
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:NotAShelf/nvf";
    nordic-nvim = {
      url = "github:AlexvZyl/nordic.nvim";
      flake = false;
    };

    zen-browser.url = "github:youwen5/zen-browser-flake";
  };

  outputs =
    { home-manager, noctalia-greeter, ... }@inputs:
    let
      lib = import ./lib.nix {
        inherit inputs;
        inherit home-manager;
        inherit noctalia-greeter;
      };
    in
    {
      nixosConfigurations = {
        ryzenix = lib.mkHost {
          hostname = "ryzenix";
          displays = [
            {
              id = "DP-1";
              width = "1920";
              height = "1200";
              offset = "1920x0";
            }
            {
              id = "HDMI-A-1";
              width = "1920";
              height = "1080";
              offset = "0x0";
            }
          ];
          displayConfig = [
            "DP-1, 1920x1200@60, 1920x0, 1"
            "HDMI-A-1, 1920x1200@60, 0x0, 1"
          ];
        };
        rognix = lib.mkHost {
          hostname = "rognix";
          displays = [
            {
              id = "eDP-1";
              width = "1920";
              height = "1080";
              offset = "0x0";
            }
            {
              id = "HDMI-A-1";
              width = "1920";
              height = "1080";
              offset = "1920x0";
            }
          ];
          displayConfig = [
            "eDP-1, 1920x1080@60, 0x0, 1"
            "HDMI-A-1, 1920x1080@60, 1920x0, 1"
          ];
        };
        nixpad = lib.mkHost {
          hostname = "nixpad";
          displays = [
            {
              id = "eDP-1";
              width = "1920";
              height = "1200";
              offset = "0x0";
            }
            {
              id = "HDMI-A-1";
              width = "1920";
              height = "1080";
              offset = "1920x0";
            }
          ];
          displayConfig = [
            "eDP-1, 1920x1200@60, 0x0, 1"
            "HDMI-A-1, 1920x1080@60, 1920x0, 1"
          ];
        };
      };
    };
}

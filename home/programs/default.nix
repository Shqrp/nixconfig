{ ... }:

{
  imports = [
    ./alacritty.nix
    ./fastfetch.nix
    ./git.nix
    ./hyprlock.nix
    ./tofi.nix
    ./vscode.nix
    ./waybar.nix
    ./zsh.nix
  ];

  programs = {
    home-manager.enable = true;
    btop = {
      enable = true;
      settings = {
        color_theme = "nord";
        update_ms = 1000;
      };
    };
  };
}

{
  inputs,
  lib,
  displays,
  system,
  getDisplay,
  ...
}:

{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${system}.hyprpaper;
    settings = {
      preload = [
        "/etc/nixos/wallpapers/display0.png"
      ]
      ++ lib.optional (builtins.length displays == 2) "/etc/nixos/wallpapers/display1.png";

      wallpaper = [
        {
          monitor = (getDisplay 0).id;
          path = "/etc/nixos/wallpapers/display0.png";
        }
      ]
      ++ lib.optional (builtins.length displays == 2) {
        monitor = (getDisplay 1).id;
        path = "/etc/nixos/wallpapers/display1.png";
      };
    };
  };
}

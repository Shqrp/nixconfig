{
  inputs,
  getDisplay,
  system,
  ...
}:

{
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${system}.hyprlock;
    settings = {
      background = {
        path = "screenshot";
        blur_passes = 1;
        noise = 0.1;
        brightness = 0.8;
      };

      input-field = {
        monitor = (getDisplay 0).id;
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0,0,0,0)";
        inner_color = "rgba(0,0,0,0.5)";
        font_color = "rgb(200,200,200)";
        fade_on_empty = false;
        font_family = "JetBrainsMono Nerd Font Mono Italic";
        placeholder_text = ''<span foreground="##cdd6f4">Input Password...</span>'';
        hide_input = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = (getDisplay 0).id;
          text = ''cmd[update:1000] echo "$(date + "%H:%M:%S")"'';
          color = "$foreground";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font Mono Italic";
          position = "0, -300";
          halign = "center";
          valign = "top";
        }
        {
          monitor = (getDisplay 0).id;
          text = "welcome to hell, $USER";
          color = "$foreground";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font Mono";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

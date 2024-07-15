{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      colors.primary = {
        background = "#242933";
        foreground = "#D8DEE9";
      };

      colors.normal = {
        black = "#3B4252";
        red = "#BF616A";
        green = "#A3BE8C";
        yellow = "#EBCB8B";
        blue = "#81A1C1";
        magenta = "#B48EAD";
        cyan = "#88C0D0";
        white = "#E5E9F0";
      };

      colors.bright = {
        black = "#4C566A";
        red = "#BF616A";
        green = "#A3BE8C";
        yellow = "#EBCB8B";
        blue = "#81A1C1";
        magenta = "#B48EAD";
        cyan = "#8FBCBB";
        white = "#ECEFF4";
      };

      window.padding = {
        x = 10;
        y = 10;
      };

      font.normal = {
        family = "JetBrains Mono Nerd Font";
        style = "Regular";
      };
      font.bold = {
        family = "JetBrains Mono Nerd Font";
        style = "Bold";
      };
      font.italic = {
        family = "JetBrains Mono Nerd Font";
        style = "Italic";
      };
      font.bold_italic = {
        family = "JetBrains Mono Nerd Font";
        style = "Bold Italic";
      };
    };
  };
}

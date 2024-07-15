{ ... }:

{
  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 5;
      font = "monospace";
      text-color = "#ECEFF4";
      background-color = "#2E3440AA";
      selection-color = "#88C0D0";

      terminal = "alacritty";
    };
  };
}

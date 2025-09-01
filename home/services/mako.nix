{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      layer = "overlay";
      backgroundColor = "#2e3440";
      borderSize = 2;
      borderColor = "#81a1c1";
      borderRadius = 15;
      defaultTimeout = 5000;
      font = "JetBrains Mono Nerd Font 10";

      "urgency=high" = {
        borderColor = "#bf616a";
        defaultTimeout = 15000;
      };
      "category=mpd" = {
        defaultTimeout = 2000;
        groupTy = "category";
      };
    };
  };
}

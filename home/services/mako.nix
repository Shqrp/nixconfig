{ ... }:

{
  services.mako = {
    enable = true;

    layer = "overlay";
    backgroundColor = "#2e3440";
    borderSize = 2;
    borderColor = "#81a1c1";
    borderRadius = 15;
    defaultTimeout = 5000;
    font = "JetBrains Mono Nerd Font 10";

    extraConfig = ''
      [urgency=high]
      border-color=#bf616a
      default-timeout=15000

      [category=mpd]
      default-timeout=2000
      group-by=category
    '';
  };
}

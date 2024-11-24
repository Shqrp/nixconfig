{ config, hostname, ... }:

{
  services.spotifyd = {
    enable = true;
    settings.global = {
      username = "1qlzuykudenvmxvdggdwf1rcm";
      password_cmd = "cat ${config.sops.secrets.spotify.path}";
      use_mpris = true;
      backend = "pulseaudio";
      device = "pipewire";
      device_name = hostname;
      bitrate = 320;
      cache_path = "/home/shqrp/.cache/spotify";
      initial_volume = "100";
      autoplay = false;
      device_type = "computer";
    };
  };
}

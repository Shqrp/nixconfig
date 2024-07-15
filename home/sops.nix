{ ... }:

{
  sops = {
    age.keyFile = "/home/shqrp/.config/sops/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets.spotify = { };
  };
}

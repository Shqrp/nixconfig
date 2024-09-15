{ ... }:

{
  sops = {
    age.keyFile = "/home/shqrp/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets.spotify = { };
  };
}

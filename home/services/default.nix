{ ... }:

{
  imports = [
    ./hypridle.nix
    ./hyprpaper.nix
    ./keyring.nix
    ./mako.nix
    ./spotifyd.nix
  ];

  services.ssh-agent.enable = true;
}

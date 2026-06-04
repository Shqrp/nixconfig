{ ... }:

{
  imports = [
    ./hypridle.nix
    ./hyprpaper.nix
    ./keyring.nix
    ./mako.nix
    ./moodle-dl.nix
    ./spotifyd.nix
  ];

  services.ssh-agent.enable = true;
  services.gpg-agent.enable = true;
}

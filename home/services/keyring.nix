{ ... }:

{
  services.gnome-keyring = {
    enable = true;
    components = [ "ssh" ];
  };
}
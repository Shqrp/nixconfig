# shqrp's nixos

This is the configuration I use for both my main machines. It's based around the [Nord color scheme](https://www.nordtheme.com/) in its dark variant.

![](https://i.imgur.com/yhK1WgI.png) ![](https://i.imgur.com/ztXq34v.png)

## Software used

- **Window Manager**: [Hyprland](https://hyprland.org)
- **Status Bar**: [Waybar](https://github.com/Alexays/Waybar)
- **Application Menu**: [Tofi](https://github.com/philj56/tofi)
- **Notification Daemon**: [mako](https://github.com/emersion/mako)
- **Screen Locker**: [Hyprlock](https://github.com/hyprwm/hyprlock)
- **Wallpaper Utility**: [Hyprpaper](https://github.com/hyprwm/hyprpaper)
- **Idle Daemon**: [Hypridle](https://github.com/hyprwm/hypridle)

+ **Terminal**: [Alacritty](https://github.com/alacritty/alacritty)
+ **Shell**: zsh with [oh-my-zsh](https://ohmyz.sh)
+ **Code Editor**: [VSCodium](https://vscodium.com)
+ **Wallpapers**: [Nordic Wallpapers](https://github.com/linuxdotexe/nordic-wallpapers)

## Directory structure

- `home/`: home-manager configuration for the `shqrp` user
- `hosts/`: hardware-specific configurations for every machine:
    - `rognix`: ASUS ROG STRIX GL753VE-GC004T (Intel Core i7-7700HQ, NVIDIA GeForce GTX 1050 Ti, 32GB DDR4 RAM)
    - `ryzenix`: my custom-built desktop (AMD Ryzen 7 3700X, NVIDIA GeForce RTX 2070 SUPER, 32GB DDR4 RAM)
- `wallpapers/`: wallpapers for both displays
- `secrets/`: contains the sops-controlled `secrets.yaml` file, which contains the Spotify password (not committed to this repository)

## Setup on your machine

- Clone the repository (`git clone https://github.com/Shqrp/nixconfig`)
- Copy your `hardware-configuration.nix` in a file named as your hostname inside the `hosts/` folder
- Import it in the `flake.nix` file
- Copy the folder's contents in `/etc/nixos`
- `sudo nixos-rebuild switch --flake /etc/nixos#{the hostname you chose}`
- Done!
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Libraries and backends
    libnotify
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    kdePackages.qtsvg
    wireplumber
    linuxHeaders

    # Utilities
    networkmanagerapplet
    playerctl
    wl-clipboard
    wget
    git
    gnupg
    gdb
    libsForQt5.qt5ct
    kdePackages.qt6ct
    gnumake
  ];

  fonts.packages = with pkgs; [
    fira-code
    jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}

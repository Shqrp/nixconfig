{ hostname, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nixcopy = "sudo cp -r ~/nixconfig/* /etc/nixos";
      nixswitch = "sudo nixos-rebuild switch --flake /etc/nixos#${hostname}";
      nixupgrade = "sudo nixos-rebuild switch --upgrade --flake /etc/nixos#${hostname}";
      nsh = "f() { export NIXPKGS_ALLOW_UNFREE=1; nix shell --impure nixpkgs#$1 };f";
      nshu = "fu() { export NIXPKGS_ALLOW_UNFREE=1; nix shell --impure github:NixOS/nixpkgs/nixos-unstable#$1 };fu";
      drunreload = "rm ~/.cache/tofi-drun";
    };
    history.size = 2048;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "gnzh";
    };
    initContent = "fastfetch";
  };
}

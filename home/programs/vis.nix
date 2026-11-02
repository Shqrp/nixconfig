{ pkgs, ... }:

{
  home.file.".config/vis/visrc.lua" = {
    enable = true;
    source = ../../config/vis/visrc.lua;
  };

  home.file.".config/vis/lexers/nix.lua" = {
    enable = true;
    source = ../../config/vis/lexers/nix.lua;
  };

  home.file.".config/vis/lexers/qml.lua" = {
    enable = true;
    source = ../../config/vis/lexers/qml.lua;
  };
}

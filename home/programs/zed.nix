{ pkgs-unstable, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;
    extensions = [
      "nix"
      "typst"
      "deno"
      "nginx"
      "cargo-appraiser"

      "opencode"

      "nordic-nvim-theme"
      "min-theme"
    ];
    extraPackages = [ pkgs-unstable.nil ];

    userSettings = {
      # Appearance
      theme = "Nordic";
      icon_theme = "Min Icons";
      buffer_font_size = 15.0;
      buffer_font_weight = 300.0;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_line_height.custom = 1.55;
      unnecessary_code_fade = 0.5;

      # Keymaps
      vim_mode = true;

      # Editor
      autosave.after_delay.milliseconds = 200;
      sticky_scroll.enabled = true;
      auto_signature_help = true;
      relative_line_numbers = "enabled";
      toolbar.code_actions = true;
      indent_guides.enabled = true;
      inlay_hints.enabled = true;
      colorize_brackets = true;
      code_lens = "on";
      soft_wrap = "editor_width";

      # Languages
      languages."Nix".language_servers = [ "nixd" "!nil" ];

      # Window & Layout
      title_bar.show_menus = true;
      tabs = {
        file_icons = true;
        git_status = true;
      };

      # Panels
      project_panel = {
        hide_root = true;
        dock = "right";
      };
      git_panel = {
        show_count_badge = true;
        file_icons = true;
        dock = "right";
      };

      telemetry = {
        diagnostics = true;
        metrics = true;
      };
    };

    userKeymaps = [
      {
        context = "vim_mode == insert";
        bindings = {
          "j k" = "vim::NormalBefore";
          "k j" = "vim::NormalBefore";
        };
      }
    ];
  };
}

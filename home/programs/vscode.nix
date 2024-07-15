{
  inputs,
  pkgs,
  system,
  ...
}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    extensions = with inputs.nix-vscode-extensions.extensions.${system}.open-vsx; [
      bradlc.vscode-tailwindcss
      dbaeumer.vscode-eslint
      denoland.vscode-deno
      esbenp.prettier-vscode
      gruntfuggly.todo-tree
      jeanp413.open-remote-ssh
      mikestead.dotenv
      ms-vscode.hexeditor
      prisma.prisma
      rust-lang.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
      usernamehw.errorlens
      jnoortheen.nix-ide
      dprint.dprint
      heybourn.headwind
      yoavbls.pretty-ts-errors
      marlosirapuan.nord-deep
      miguelsolorio.fluent-icons
    ];
    userSettings = {
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Nord Deep";
      "workbench.productIconTheme" = "fluent-icons";
      "workbench.sideBar.location" = "right";

      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 1;

      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 500;

      "explorer.confirmDragAndDrop" = false;
      "explorer.confirmDelete" = false;

      "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.inlayHints.enabled" = "onUnlessPressed";
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.formatOnSave" = true;

      "[css]" = {
        "editor.defaultFormatter" = "vscode.css-language-features";
      };
      "[html]" = {
        "editor.defaultFormatter" = "vscode.html-language-features";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[prisma]" = {
        "editor.defaultFormatter" = "Prisma.prisma";
      };
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableCommitSigning" = true;
      "git.enableSmartCommit" = true;

      "npm.packageManager" = "pnpm";

      "typescript.updateImportsOnFileMove.enabled" = "always";

      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "nixfmt";
      "nix.serverPath" = "nixd";
    };
  };
}

{
  inputs,
  pkgs-unstable,
  system,
  ...
}:

{
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium-fhs;
    extensions =
      (with inputs.nix-vscode-extensions.extensions.${system}.open-vsx; [
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        denoland.vscode-deno
        dprint.dprint
        eamodio.gitlens
        esbenp.prettier-vscode
        gruntfuggly.todo-tree
        heybourn.headwind
        jeanp413.open-remote-ssh
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        marlosirapuan.nord-deep
        miguelsolorio.fluent-icons
        mikestead.dotenv
        ms-python.python
        ms-toolsai.jupyter
        ms-vscode.hexeditor
        ms-vscode.cmake-tools
        prisma.prisma
        rust-lang.rust-analyzer
        serayuzgur.crates
        tamasfe.even-better-toml
        usernamehw.errorlens
        yoavbls.pretty-ts-errors
        zxh404.vscode-proto3
      ])
      ++ (with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace-release; []);
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

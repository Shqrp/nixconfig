{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:

{
  home.file."${config.xdg.configHome}/nvf/spell/it.utf-8.spl".source = builtins.fetchurl {
    url = "http://ftp.nluug.nl/vim/runtime/spell/it.utf-8.spl";
    sha256 = "04vlmri8fsza38w7pvkslyi3qrlzyb1c3f0a1iwm6vc37s8361yq";

  };

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        preventJunkFiles = false;
        options.backupdir = "${config.xdg.configHome}/.local/state/nvf/backup//";

        extraPackages = with pkgs; [ nixfmt ];
        extraPlugins = {
          nordic = {
            package = pkgs.vimUtils.buildVimPlugin {
              name = "nordic-nvim";
              src = inputs.nordic-nvim;
            };
            setup = ''
              require("nordic").load()
              vim.cmd[[colorscheme nordic]]
            '';
          };
        };

        languages = {
          enableTreesitter = true;

          rust.enable = true;
          nix.enable = true;
          typescript.enable = true;
          astro.enable = true;
          python.enable = true;
          html.enable = true;
          css.enable = true;
          lua.enable = true;
          typst = {
            enable = true;
            extensions.typst-preview-nvim.enable = true;
          };
          clang.enable = true;
          kotlin.enable = true;
        };
        lsp = {
          enable = true;

          mappings = {
            codeAction = "<leader>lca";
            format = "<leader>ff";
            listDocumentSymbols = "<leader>lds";
            listReferences = "<leader>lrr";
            renameSymbol = "<leader>lrs";
          };
          servers.protols = {
            cmd = [ (lib.getExe pkgs.protols) ];
            filetypes = [ "proto" ];
          };
          servers.clangd.filetypes = lib.mkForce [
            "c"
            "cpp"
            "objc"
            "objcpp"
            "cuda"
            "h"
            "hpp"
          ];
          presets.tailwindcss-language-server.enable = true;
        };
        # Customized spellcheck setup, inspired from NVF
        augroups = [ { name = "typstmd_spellcheck"; } ];
        autocmds = [
          {
            event = [ "FileType" ];
            group = "typstmd_spellcheck";
            desc = "Activate spellcheck on Typst and Markdown files";
            pattern = [
              "markdown"
              "typst"
            ];
            command = "setlocal spell spelllang=en,it";
          }
        ];
        treesitter = {
          context.enable = true;
          fold = true;
        };

        autocomplete.nvim-cmp = {
          enable = true;

          mappings = {
            confirm = "<S-CR>";
            close = "<M-Tab>";
          };
        };

        dashboard.dashboard-nvim = {
          enable = true;
          setupOpts = {
            config = {
              header = [
                ""
                "  ██████  ██░ ██   █████   ██▀███   ██▓███        ██▓     ▒█████   ██▓    "
                "▒██    ▒ ▓██░ ██▒▒██▓  ██▒▓██ ▒ ██▒▓██░  ██▒     ▓██▒    ▒██▒  ██▒▓██▒    "
                "░ ▓██▄   ▒██▀▀██░▒██▒  ██░▓██ ░▄█ ▒▓██░ ██▓▒     ▒██░    ▒██░  ██▒▒██░    "
                "  ▒   ██▒░▓█ ░██ ░██  █▀ ░▒██▀▀█▄  ▒██▄█▓▒ ▒     ▒██░    ▒██   ██░▒██░    "
                "▒██████▒▒░▓█▒░██▓░▒███▒█▄ ░██▓ ▒██▒▒██▒ ░  ░ ██▓ ░██████▒░ ████▓▒░░██████▒"
                "▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░░ ▒▒░ ▒ ░ ▒▓ ░▒▓░▒▓▒░ ░  ░ ▒▓▒ ░ ▒░▓  ░░ ▒░▒░▒░ ░ ▒░▓  ░"
                "░ ░▒  ░ ░ ▒ ░▒░ ░ ░ ▒░  ░   ░▒ ░ ▒░░▒ ░      ░▒  ░ ░ ▒  ░  ░ ▒ ▒░ ░ ░ ▒  ░"
                "░  ░  ░   ░  ░░ ░   ░   ░   ░░   ░ ░░        ░     ░ ░   ░ ░ ░ ▒    ░ ░   "
                "      ░   ░  ░  ░    ░       ░                ░      ░  ░    ░ ░      ░  ░"
                "                                              ░                           "
              ];
              project = {
                action = ":FzfLua files cwd=";
              };
            };
          };
        };

        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            enable_cursor_hijack = true;
            enable_diagnostics = true;
            enable_git_status = true;
            enable_modified_markers = true;
            git_status_async = true;
            source_selector.winbar = true;
          };
        };

        formatter.conform-nvim = {
          enable = true;
          setupOpts = {
            format_on_save = {
              timeout_ms = 500;
              lsp_format = "fallback";
            };
            formatters_by_ft = {
              lua = [ "stylua" ];
              nix = [ "nixfmt" ];
              typst = [ "typstyle" ];
            };
          };
        };

        fzf-lua = {
          enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;

          neogit = {
            enable = true;
            setupOpts.integrations.fzf_lua = true;
          };
        };

        mini = {
          comment.enable = true;
          cursorword.enable = true;
          move.enable = true;
          pairs.enable = true;
          surround.enable = true;
        };

        statusline.lualine = {
          enable = true;
          theme = "auto";

          activeSection = {
            a = [
              ''
                {
                  "mode",
                  icons_enabled = true,
                }
              ''
            ];
            b = [
              ''
                {
                  "filetype",
                  { icon_only = true },
                  "filename"
                }
              ''
            ];
            c = [
              ''
                {
                  "diagnostics",
                  sources = { "nvim_lsp" },
                  symbols = { error = "", warn = "", info = ""},
                  diagnostics_color = {
                    error = { fg = "#bf616a" },
                    warn = { fg = "#ebcb8b" },
                    info = { fg = "#5e81ac" }
                  }
                }
              ''
            ];
            x = [
              ''
                {
                  "lsp_status"
                }
              ''
            ];
            y = [
              ''
                {
                  "branch"
                }
              ''
            ];
            z = [
              ''
                {
                  "location",
                  "progress"
                }
              ''
            ];

          };
          sectionSeparator = {
            left = "";
            right = "";
          };
          disabledFiletypes.statusline = [ "dashboard" ];
        };
        notify.nvim-notify = {
          enable = true;
          setupOpts = {
            render = "wrapped-compact";
            stages = "fade_in_slide_out";
          };
        };

        tabline.nvimBufferline = {
          enable = true;

          setupOpts = {
            options = {
              numbers = "none";
              separator_style = "thin";
              indicator.style = "icon";
            };
          };
          mappings = {
            moveNext = "<leader>bml";
            movePrevious = "<leader>bmh";
          };
        };

        ui = {
          breadcrumbs.enable = true;
          colorful-menu-nvim.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = true;
        };
        visuals = {
          indent-blankline = {
            enable = true;
            setupOpts.exclude.filetypes = [ "dashboard" ];
          };
          nvim-scrollbar = {
            enable = true;
            setupOpts.excluded_filetypes = [ "dashboard" ];
          };
          nvim-web-devicons.enable = true;
          rainbow-delimiters.enable = true;
        };

        utility.motion.precognition = {
          enable = false;
          setupOpts.disabled_fts = [ "dashboard" ];
        };

        keymaps = [
          {
            key = "jk";
            mode = "i";
            action = "<C-[>";
          }
          {
            key = "kj";
            mode = "i";
            action = "<C-[>";
          }
          {
            key = "<leader>ltd";
            mode = "n";
            action = ":FzfLua lsp_typedefs<CR>";
          }
          {
            key = "<leader>ldd";
            mode = "n";
            action = ":FzfLua lsp_definitions<CR>";
          }
          {
            key = "<leader>lih";
            mode = "n";
            action = "vim.lsp.inlay_hint.enable";
            lua = true;
          }
          {
            key = "<leader>ldg";
            mode = "n";
            action = ":FzfLua lsp_document_diagnostics<CR>";
          }
          {
            key = "<leader>fp";
            mode = "n";
            action = ":Neotree toggle dir=./ position=right<CR>";
          }
          {
            key = "<leader>gr";
            mode = "n";
            action = ":FzfLua live_grep<CR>";
          }
          {
            key = "<leader>o";
            mode = "n";
            action = ":FzfLua git_files<CR>";
          }
          {
            key = "<leader>gg";
            mode = "n";
            action = ":Neogit kind=floating<CR>";
          }
          {
            key = "<leader>bh";
            mode = "n";
            action = ":BufferLineCyclePrev<CR>";
          }
          {
            key = "<leader>bl";
            mode = "n";
            action = ":BufferLineCycleNext<CR>";
          }
          {
            key = "<leader>bc";
            mode = "n";
            action = ":bdelete<CR>";
          }
          {
            key = "<leader>bp";
            mode = "n";
            action = ":BufferLinePick<CR>";
          }
          {
            key = "<F11>";
            mode = [
              "n"
              "i"
              "v"
              "c"
              "o"
              "t"
              "l"
            ];
            action = ":let neovide_fullscreen = !neovide_fullscreen<CR>";
          }
        ];
      };
    };
  };
}

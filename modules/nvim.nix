{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      mini-nvim
      blink-cmp
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.c_sharp
        p.ocaml
        p.zig
        p.nix
        p.ini
        p.json
        p.typescript
        p.javascript
        p.tsx
      ]))
    ];

    initLua = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      vim.o.spell = true
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.clipboard = "unnamedplus"
      vim.o.undofile = true
      vim.o.ignorecase = true
      vim.o.smartcase = true

      vim.cmd("colorscheme tokyonight-night")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cpp",
        callback = function()
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function()
          vim.bo.tabstop = 4
          vim.bo.shiftwidth = 4
          vim.bo.expandtab = true
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "nix",
        callback = function()
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "js",
        callback = function()
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ts",
        callback = function()
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end,
      })

      require("blink.cmp").setup({
        keymap = { preset = "default" },
        sources = {
          default = { "buffer", "path", "snippets" },
        },
        completion = {
          menu = { auto_show = true },
        },
      })

      require("mini.comment").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.extra").setup()
      require("mini.move").setup()
      require("mini.pick").setup({
        source = { show = require("mini.pick").default_show },
        window = {
          config = function()
            local height = math.floor(vim.o.lines * 0.50)
            return {
              relative = "editor",
              anchor = "SW",
              row = vim.o.lines - 1,
              col = 0,
              width = vim.o.columns,
              height = height,
            }
          end,
        },
      })

      local pick = require("mini.pick")
      local extra = require("mini.extra")
      local map = vim.keymap.set

      map("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear search" })
      map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
      map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
      map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
      map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

      map("n", "<leader>f", pick.builtin.files, { desc = "Files" })
      map("n", "<leader>b", pick.builtin.buffers, { desc = "Buffers" })
      map("n", "<leader>g", pick.builtin.grep_live, { desc = "Grep" })
      map("n", "<leader>k", extra.pickers.keymaps, { desc = "Keymaps" })

      vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("yank-hl", { clear = true }),
        callback = function() vim.highlight.on_yank() end,
      })
    '';
  };
}

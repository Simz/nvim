vim.g.mapleader = ","
vim.g.maplocalleader = ","


vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4      -- A tab counts for 4 spaces
vim.opt.shiftwidth = 4   -- Size of an indent
vim.opt.softtabstop = 4


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.undofile = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

vim.opt.cursorline = true

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = tree

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

vim.cmd.colorscheme("catppuccin")


local utils = require('utils')
vim.g.mapleader = ','

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'

utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)
utils.opt('o', 'scrolloff', 4)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('o', 'updatetime', 300)
utils.opt('o', 'mouse', '')
utils.opt('o', 'clipboard', 'unnamedplus')

local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    q = { "<cmd>NvimTreeToggle<CR>", "Open file tree" },
    p = { '<cmd>Telescope find_files find_command=rg,--no-ignore-vcs,--hidden,--files<CR>', "Fzf all files" },
    c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
    ["1"] = { '<cmd>BufferGoto1<CR>', "Goto tab 1" },
    ["2"] = { '<cmd>BufferGoto2<CR>', "Goto tab 2" },
    ["3"] = { '<cmd>BufferGoto3<CR>', "Goto tab 3" },
    ["4"] = { '<cmd>BufferGoto4<CR>', "Goto tab 4" },
    ["5"] = { '<cmd>BufferGoto5<CR>', "Goto tab 5" },
    ["6"] = { '<cmd>BufferGoto6<CR>', "Goto tab 6" },
    ["7"] = { '<cmd>BufferGoto7<CR>', "Goto tab 7" },
    ["8"] = { '<cmd>BufferGoto8<CR>', "Goto tab 8" },
    ["9"] = { '<cmd>BufferGoto9<CR>', "Goto tab 9" },
    g = {
      p = { "<cmd>Gitsign preview_hunk<CR>", "GS preview_hunk" },
      b = { "<cmd>Gitsign blame_line<CR>", "GS blame line" },
      o = { "<cmd>GitConflictChooseOurs<CR>", "GC choose our" },
      t = { "<cmd>GitConflictChooseTheirs<CR>", "GC choose theirs" },
      n = { "<cmd>:GitConflictNextConflict<CR>", "GC next conflict" },
    },
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
    v = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Debug value" },
    d = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle debuging UI" },
    l = { "<cmd>DiffviewClose<CR>", "DiffviewClose" },
    f = { '<cmd>lua vim.lsp.buf.format { async = true }<CR>', "Format buffer" },
  },
  ["<C-p>"] = { '<cmd>Telescope find_files<CR>', "" },
  ["<C-f>"] = { '<cmd>Telescope live_grep<CR>', "" },
  ["<C-i>"] = { '<cmd>lua vim.lsp.buf.formatting()<CR>', "" },
  ["gD"] = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "" },
  ["gd"] = { '<cmd>lua vim.lsp.buf.definition()<CR>', "" },
  ["K"] = { '<cmd>lua vim.lsp.buf.hover()<CR>', "" },
  ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "" },
  ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "" },
  ["<F8>"] = { "<cmd>lua require'dap'.step_into()<CR>", "" },
  ["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "" },
})





vim.api.nvim_command [[

  hi cursorline cterm=none term=none
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  highlight CursorLine guibg=#303000 ctermbg=234

]]

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
-- utils.opt('o', 'clipboard','unnamedplus')


--utils.map('n', '<leader>q', '<cmd>CHADopen<CR>')
utils.map('n', '<leader>q', '<cmd>NvimTreeToggle<CR>')
--utils.map('n', '<leader>t', '<cmd>FloatermToggle<CR>')
utils.map('n', '<leader>t', '<cmd>lua require"localfn".docker_logs()<CR>')
utils.map('n', '<C-p>', '<cmd>Telescope find_files<CR>')
utils.map('n', '<leader>p', '<cmd>Telescope find_files find_command=rg,--no-ignore-vcs,--hidden,--files<CR>')
utils.map('n', '<C-f>', '<cmd>Telescope live_grep<CR>')
utils.map('n', '<C-i>', '<cmd>lua vim.lsp.buf.formatting()<CR>')
utils.map('n', '<leader>1', '1gt')
utils.map('n', '<leader>2', '2gt')
utils.map('n', '<leader>3', '3gt')
utils.map('n', '<leader>4', '4gt')
utils.map('n', '<leader>5', '5gt')
utils.map('n', '<leader>6', '6gt')
utils.map('n', '<leader>7', '7gt')
utils.map('n', '<leader>8', '8gt')
utils.map('n', '<leader>9', '9gt')
utils.map('n', '<leader>g', '<cmd>vertical Git<CR>')
utils.map('t', '<Esc>', '<C-\\><C-n>:FloatermToggle<CR>')
utils.map('n', '<F5>', "<cmd>lua require'dap'.continue()<CR>")
utils.map('n', '<F10>', "<cmd>lua require'dap'.step_over()<CR>")
utils.map('n', '<F8>', "<cmd>lua require'dap'.step_into()<CR>")
utils.map('n', '<F12>', "<cmd>lua require'dap'.step_out()<CR>")
utils.map('n', '<leader>b', "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
utils.map('n', '<leader>i', "<cmd>lua inspectcursor()<CR>")
utils.map('n', '<leader>d', "<cmd>lua require'dapui'.toggle()<CR>")
utils.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
utils.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
utils.map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>')

-- CHADTree
local chadtree_settings = { keymap = { tertiary = { "t" }, trash = { "T" } } }
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)


-- autotag
require 'nvim-treesitter.configs'.setup {
    autotag = {
        enable = true,
    }
}

--vimsign


vim.api.nvim_command[[
  highlight LightspeedLabel ctermfg=blue
  highlight LightspeedLabelOverlapped ctermfg=yellow
  highlight LightspeedShortcut ctermfg=yellow ctermbg=NONE
]]


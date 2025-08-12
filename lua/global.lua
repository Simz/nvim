local utils = require('utils')
vim.g.mapleader = ','

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
vim.cmd [[ autocmd BufNewFile,BufRead *.typoscript setfiletype typoscript ]]


vim.g.dbs = {
  {
    name = 'dev',
    url = function()
      local cwd = vim.fn.getcwd()
      local dir = cwd:match("([^/]+)$")
      local ip = (io.popen("docker inspect " .. dir .. "-db-1  | jq -r 'first(.[0].NetworkSettings.Networks[].IPAddress)'"):read("*a"))
          :gsub("%s*$", "")

      print("Found IP for '" .. dir .. "-db-1': " .. ip)
      if ip ~= "" then
        --        return "mysql://dev:dev@db:3306/dev"
        return "mysql://dev:dev@" .. ip .. ":3306/dev"
      else
        return "Container not found or no IP assigned"
      end
    end

  },
}

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
utils.opt('o', 'clipboard', 'unnamed')

local wk = require("which-key")
wk.add(
  {
    { "<C-f>",      "<cmd>FzfLua live_grep<CR>",                                                      desc = "" },
    { "<C-i>",      "<cmd>lua vim.lsp.buf.formatting()<CR>",                                          desc = "" },
    { "<C-p>",      "<cmd>FzfLua files<CR>",                                                          desc = "" },
    { "<F10>",      "<cmd>lua require'dap'.step_over()<CR>",                                          desc = "" },
    { "<F12>",      "<cmd>lua require'dap'.step_out()<CR>",                                           desc = "" },
    { "<F5>",       "<cmd>lua require'dap'.continue()<CR>",                                           desc = "" },
    { "<F8>",       "<cmd>lua require'dap'.step_into()<CR>",                                          desc = "" },
    { "<leader>1",  "<cmd>BufferGoto1<CR>",                                                           desc = "Goto tab 1" },
    { "<leader>2",  "<cmd>BufferGoto2<CR>",                                                           desc = "Goto tab 2" },
    { "<leader>3",  "<cmd>BufferGoto3<CR>",                                                           desc = "Goto tab 3" },
    { "<leader>4",  "<cmd>BufferGoto4<CR>",                                                           desc = "Goto tab 4" },
    { "<leader>5",  "<cmd>BufferGoto5<CR>",                                                           desc = "Goto tab 5" },
    { "<leader>6",  "<cmd>BufferGoto6<CR>",                                                           desc = "Goto tab 6" },
    { "<leader>7",  "<cmd>BufferGoto7<CR>",                                                           desc = "Goto tab 7" },
    { "<leader>8",  "<cmd>BufferGoto8<CR>",                                                           desc = "Goto tab 8" },
    { "<leader>9",  "<cmd>BufferGoto9<CR>",                                                           desc = "Goto tab 9" },
    { "<leader>b",  "<cmd>lua require'dap'.toggle_breakpoint()<CR>",                                  desc = "Toggle breakpoint" },
    { "<leader>c",  "<cmd>FzfLua lsp_code_actions<CR>",                                               desc = "Code action" },
    --    { "<leader>c",  "<cmd>lua vim.lsp.buf.code_action()<CR>",                                         desc = "Code action" },
    { "<leader>d",  "<cmd>lua require'dapui'.toggle()<CR>",                                           desc = "Toggle debuging UI" },
    { "<leader>f",  "<cmd>lua vim.lsp.buf.format { async = true }<CR>",                               desc = "Format buffer" },
    { "<leader>gb", "<cmd>Gitsign blame_line<CR>",                                                    desc = "GS blame line" },
    { "<leader>gn", "<cmd>:GitConflictNextConflict<CR>",                                              desc = "GC next conflict" },
    { "<leader>go", "<cmd>GitConflictChooseOurs<CR>",                                                 desc = "GC choose our" },
    { "<leader>gp", "<cmd>Gitsign preview_hunk<CR>",                                                  desc = "GS preview_hunk" },
    { "<leader>gt", "<cmd>GitConflictChooseTheirs<CR>",                                               desc = "GC choose theirs" },
    { "<leader>l",  "<cmd>DiffviewClose<CR>",                                                         desc = "DiffviewClose" },
    { "<leader>p",  "<cmd>Telescope find_files find_command=rg,--no-ignore-vcs,--hidden,--files<CR>", desc = "Fzf all files" },
    { "<leader>q",  "<cmd>NvimTreeToggle<CR>",                                                        desc = "Open file tree" },
    { "<leader>v",  "<cmd>lua require('dap.ui.widgets').hover()<CR>",                                 desc = "Debug value" },
    { "K",          "<cmd>lua vim.lsp.buf.hover()<CR>",                                               desc = "" },
    { "gD",         "<cmd>lua vim.lsp.buf.declaration()<CR>",                                         desc = "" },
    { "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>",                                          desc = "" },
  }

)





vim.api.nvim_command [[

  hi cursorline cterm=none term=none
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  highlight CursorLine guibg=#303000 ctermbg=234

]]

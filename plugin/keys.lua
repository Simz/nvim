vim.pack.add {
    { src = "https://github.com/folke/which-key.nvim" }
}
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})

local wk = require("which-key")
wk.add(
    {
        { "<C-f>",      "<cmd>FzfLua live_grep<CR>",                                                      desc = "" },
        { "<C-i>",      "<cmd>Format<CR>",                                              desc = "" },
        -- { "<C-i>",      "<cmd>lua vim.lsp.buf.format()<CR>",                                              desc = "" },
        { "<C-l>",      "<cmd>lua require('lint').try_lint()<CR>",                                        desc = "" },
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
        { "<leader>l",      "<cmd>lua require('lint').try_lint()<CR>",                                        desc = "" },
        { "<leader>p",  "<cmd>:lua require('fzf-lua').files({ cmd = 'rg --files --hidden --no-ignore' })<CR>", desc = "Fzf all files" },
        { "<leader>q",  "<cmd>NvimTreeToggle<CR>",                                                        desc = "Open file tree" },
        { "<leader>v",  "<cmd>lua require('dap.ui.widgets').hover()<CR>",                                 desc = "Debug value" },
        { "K",          "<cmd>lua vim.lsp.buf.hover()<CR>",                                               desc = "" },
        { "gD",         "<cmd>lua vim.lsp.buf.declaration()<CR>",                                         desc = "" },
        { "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>",                                          desc = "" },
    }

)

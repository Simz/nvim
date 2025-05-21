-- examples for your init.lua


-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
    on_attach = on_attach,
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    actions = { open_file = { quit_on_open = true, } }
})
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.typoscript = {
    install_info = {
        url = "~/src/tree-sitter-typoscript/",  -- local path or git repo
        files = { "src/parser.c" },             -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = "main",                        -- default branch in case of git repo if different from master
        generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "typoscript",                    -- if filetype does not match the parser name
}

vim.pack.add({ 'https://github.com/nvim-tree/nvim-tree.lua' })
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

vim.pack.add({ 'https://github.com/saghen/blink.lib' })
vim.pack.add({ 'https://github.com/saghen/blink.cmp' })
require('blink.cmp').setup({
    keymap = { preset = 'enter' },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            snippets = {
                name = 'Snippets',
                module = 'blink.cmp.sources.snippets',
                opts = {
                    search_paths = {
                        vim.fn.stdpath("config") .. "/vscodeSnippets"
                    }
                }
            }
        }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

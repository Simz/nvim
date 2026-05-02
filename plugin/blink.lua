vim.pack.add({ 'https://github.com/saghen/blink.lib' })
vim.pack.add({ 'https://github.com/saghen/blink.cmp' })
pcall(function()
    require('blink.cmp').build():wait(60000)
    require('blink.cmp').setup({
        keymap = {
            preset = 'enter',
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = { documentation = { auto_show = false } },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    })
end)

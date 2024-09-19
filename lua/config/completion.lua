local cmp = require 'cmp'

local next = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
end, { "i", "s" })

local prev = cmp.mapping(function()
    if cmp.visible() then
        cmp.select_prev_item()
    end
end, { "i", "s" })

cmp.setup({
    snippet = {
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<Down>'] = next,
        --        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = next,
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<S-Tab>"] = prev,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'calc' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
    },
})

vim.api.nvim_set_keymap('i', '<C-y>', 'copilot#Accept("<CR>")', { expr = true, silent = true })

--
--  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--  cmp.setup.cmdline({ '/', '?' }, {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {
--      { name = 'buffer' }
--    }
--  })
--
--  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--  cmp.setup.cmdline(':', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = cmp.config.sources({
--      { name = 'path' }
--    }, {
--      { name = 'cmdline' }
--    })
--  })
--

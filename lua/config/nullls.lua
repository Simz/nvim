local null_ls = require("null-ls")

null_ls.setup({
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    --vim.lsp.buf.formatting_sync()
                    print(client)
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    sources = {
        -- yaml
        null_ls.builtins.diagnostics.yamllint,
        -- js
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettier.with({
		    filetypes = {
                "javascript","typescript","css","scss","html","json",
            },
        }),
        null_ls.builtins.code_actions.eslint_d,
        -- python
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black.with({
        --            extra_args = {"--line-length", "120"},
        }),
        null_ls.builtins.diagnostics.flake8,
    },
})

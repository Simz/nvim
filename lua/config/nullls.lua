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
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    sources = {
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.isort,
      --  null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.black.with({
            extra_args = {"--line-length", "100"},
      --      command = "/home/souellet/www/spectra-application/backend/.venv/bin/black",
        }),
        null_ls.builtins.formatting.flake8
    },
})

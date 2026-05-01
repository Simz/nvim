local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local typoscriptlint = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "typoscript" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator({
        command = vim.fn.expand("~/.composer/vendor/bin/typoscript-lint"),
        args = { "--fail-on-warnings", "-f", "gcc", "$FILENAME" },
        to_stdin = true,
        from_stderr = false,
        -- choose an output format (raw, json, or line)
        format = "line",

        check_exit_code = function(code, stderr)
            local success = code <= 2

            if not success then
                -- can be noisy for things that run often (e.g. diagnostics), but can
                -- be useful for things that run on demand (e.g. formatting)
                print(stderr)
            end

            return success
        end,
        on_output = helpers.diagnostics.from_pattern(
            [[^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$]],
            -- [[(%w+):(%d+):(%d+): (%w+): (.*)]],
            { "filename", "row", "col", "severity", "message" },
            {
                severities = {
                    ["fatal error"] = helpers.diagnostics.severities.error,
                    ["error"] = helpers.diagnostics.severities.error,
                    ["note"] = helpers.diagnostics.severities.information,
                    ["warning"] = helpers.diagnostics.severities.warning,
                },
            }
        ),
    }),
}

null_ls.setup({
    debug = true,
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
        -- yaml
        null_ls.builtins.diagnostics.yamllint,
        -- php
        null_ls.builtins.formatting.phpcsfixer,
        -- typoscript
        typoscriptlint,
        -- js
        require("none-ls.code_actions.eslint"),
        require("none-ls.diagnostics.eslint"),
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "javascript", "html", "typescript", "css", "scss", "json", "markdown", "graphql", "md", "txt", "yaml"
            },
        }),
    },
})

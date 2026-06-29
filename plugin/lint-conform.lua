vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })
require('lint').linters.fluid = {
    cmd = 'docker',
    args = { 'exec', '-u', 'www-data', '-i', 'grt-site-web-v14-php-fpm-1', './vendor/bin/typo3', 'fluid:analyze', '--json', '--stdin' },
    stdin = true,
    append_fname = false,
    stream = 'stdout',
    ignore_exitcode = true,
    parser = function(output, bufnr)
        local diagnostics = {}
        local ok, decoded = pcall(vim.json.decode, output)
        if not ok or type(decoded) ~= "table" then
            for line_str in output:gmatch("[^\r\n]+") do
                local line, col, msg = line_str:match("line (%d+) at character (%d+)%. Error: (.*)")
                if line and col and msg then
                    -- Strip trailing context info if it's too long
                    msg = msg:gsub("%. Template source chunk:.*$", "")
                    table.insert(diagnostics, {
                        bufnr = bufnr,
                        lnum = tonumber(line) - 1,
                        col = tonumber(col) - 1,
                        end_lnum = tonumber(line) - 1,
                        end_col = tonumber(col) - 1,
                        severity = vim.diagnostic.severity.ERROR,
                        message = msg,
                        source = 'fluid',
                    })
                else
                    local type_str, text_msg = line_str:match("^%[(%a+)%]%s+[^:]+:%s+(.*)")
                    if type_str and text_msg then
                        table.insert(diagnostics, {
                            bufnr = bufnr,
                            lnum = 0,
                            col = 0,
                            severity = type_str == "ERROR" and vim.diagnostic.severity.ERROR or
                            vim.diagnostic.severity.WARN,
                            message = text_msg,
                            source = 'fluid',
                        })
                    end
                end
            end
            return diagnostics
        end

        -- Standardize to a list of reports (stdin returns single object, file list returns array)
        local reports = {}
        if decoded.path then
            table.insert(reports, decoded)
        else
            reports = decoded
        end

        for _, file_report in ipairs(reports) do
            -- Errors
            if file_report.errors then
                for _, err in ipairs(file_report.errors) do
                    local line = 0
                    local col = 0
                    if err.templateLocation then
                        line = (err.templateLocation.line or 1) - 1
                        col = (err.templateLocation.character or 1) - 1
                    elseif err.line then
                        line = err.line - 1
                    end

                    table.insert(diagnostics, {
                        bufnr = bufnr,
                        lnum = line,
                        col = col,
                        end_lnum = line,
                        end_col = col,
                        severity = vim.diagnostic.severity.ERROR,
                        message = err.message,
                        source = 'fluid',
                    })
                end
            end

            -- Deprecations
            if file_report.deprecations then
                for _, dep in ipairs(file_report.deprecations) do
                    local line = (dep.line or 1) - 1
                    table.insert(diagnostics, {
                        bufnr = bufnr,
                        lnum = line,
                        col = 0,
                        end_lnum = line,
                        end_col = 0,
                        severity = vim.diagnostic.severity.WARN,
                        message = dep.message,
                        source = 'fluid',
                    })
                end
            end
        end

        return diagnostics
    end,
}
require('lint').linters_by_ft = {
    yaml = { 'yamllint' },
    html = { 'fluid' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
    end,
})

vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
require("conform").setup({
    formatters_by_ft = {
        html = { "html-beautify" },
        json = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
        ["html-beautify"] = {
            prepend_args = { "--editorconfig" },
        },
    },

})

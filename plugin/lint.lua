vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })
require('lint').linters_by_ft = {
    yaml = { 'yamllint' },
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
        html = { "prettierd", "prettier", stop_after_first = true },
    },

})

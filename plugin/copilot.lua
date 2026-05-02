vim.pack.add({ 'https://github.com/copilotlsp-nvim/copilot-lsp' })
vim.pack.add({ 'https://github.com/zbirenbaum/copilot.lua' })
pcall(function()
    vim.lsp.enable("copilot_ls")
    require("copilot").setup({
        filetypes = { ["*"] = true },
        suggestion = {
            enable = true,
            auto_trigger = true,
        },
        nes = {
            enabled = true,
            keymap = {
                accept_and_goto = "<Tab>",
                accept = false,
                dismiss = "<Esc>",
            },
        },
    })
    vim.keymap.set('i', '<C-y>', function()
        require('copilot.suggestion').accept()
    end, { desc = 'Accept Copilot suggestion' })
end)

vim.pack.add({ 'https://github.com/zbirenbaum/copilot.lua' })
vim.pack.add({ 'https://github.com/copilotlsp-nvim/copilot-lsp' })
vim.lsp.enable("copilot_ls")
pcall(function()
    require("copilot").setup({
        filetypes = { ["*"] = true },
        suggestion = { auto_trigger = true, keymap = { accept = "<C-y>" } },
    })
end)

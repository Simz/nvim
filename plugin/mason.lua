vim.pack.add({ 'https://github.com/williamboman/mason.nvim' })
vim.pack.add({ 'https://github.com/williamboman/mason-lspconfig.nvim' })
pcall(require, "config/mason")
pcall(function() require('mason-lspconfig').setup() end)

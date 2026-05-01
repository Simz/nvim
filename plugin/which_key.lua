vim.o.timeout = true
vim.o.timeoutlen = 300
vim.pack.add({ 'https://github.com/folke/which-key.nvim' })
pcall(function() require('which-key').setup({ triggers = { "<leader>" } }) end)

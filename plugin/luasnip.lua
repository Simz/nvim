vim.pack.add({'https://github.com/rafamadriz/friendly-snippets'})
vim.pack.add({'https://github.com/L3MON4D3/LuaSnip'})
require("luasnip.loaders.from_vscode").load({ paths = { "./vscodeSnippets" } })


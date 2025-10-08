
return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "lua", "python", "rust", "php", "typescript", "css", "javascript", "html" },
            highlight = {
                enable = true,
            }
        }
    end
}

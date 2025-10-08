
return {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    config = function()
        require("config/onedark")
        vim.cmd([[colorscheme onedark]])
    end,
}

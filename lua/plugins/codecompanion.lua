
return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        strategies = {
            --NOTE: Change the adapter as required
            chat = { adapter = "gemini" },
            inline = { adapter = "gemini" },
        },
    },
}

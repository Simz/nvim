
return {
    "FeiyouG/command_center.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("config/palette")
    end,
}

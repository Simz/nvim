
return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    priority = 1,
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
        require("config/tree-conf")
    end,
}


return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-dap-python"
    },
    config = function()
        require("config/dap")
    end,
}

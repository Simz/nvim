
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "mfussenegger/nvim-dap-python"
    },
    config = function()
        require("config/dap")
    end,
}

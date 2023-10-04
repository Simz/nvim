require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
    },
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

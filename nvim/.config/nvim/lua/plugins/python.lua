require("lspconfig").pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                black = { enabled = true },
                isort = { enabled = true },
            },
        },
    },
})

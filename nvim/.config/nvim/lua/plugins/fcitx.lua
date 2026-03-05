return {
    "h-hg/fcitx.nvim",
    event = "InsertEnter",
    config = function()
        vim.g.fcitx5_remote = "fcitx5-remote"
    end,
}

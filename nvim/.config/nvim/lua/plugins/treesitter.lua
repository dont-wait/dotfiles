-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.config")
    configs.setup({
        auto_install = true,
        ensure_installed = {
        "lua",
        "vim",
        "go",
        "javascript",
        "typescript",
        "html",
        "json",
        "zig",
        "c",
        "cpp",
        "java",
        "c_sharp",
        "tsx",
        "jsx",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    })
  end,
}



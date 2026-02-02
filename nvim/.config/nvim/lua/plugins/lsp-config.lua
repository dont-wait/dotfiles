
-- lspconfig.lua
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        --just in nixos 
        ensure_installed = {},
        automatic_installation = false,
      })
    end,
  },
  -- lspconfig.lua (Phần block số 3 đã update)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Lấy capabilities để support auto-completion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 1. Danh sách các server cài qua NixOS (trừ lua_ls cấu hình riêng)
      local servers = {
        "ts_ls",       -- Typescript
        "html",
        "cssls",
        "tailwindcss",
        "gopls",       -- Go
        "pyright",     -- Python
        "nil_ls",      -- Nix
        "dockerls",
        "yamlls",
        "bashls",
      }

      -- 2. Vòng lặp setup kiểu mới (Neovim 0.11+)
      for _, server in ipairs(servers) do
        -- Thay vì .setup(), ta gán trực tiếp vào vim.lsp.config
        vim.lsp.config[server] = {
          capabilities = capabilities,
        }
        -- Bắt buộc phải enable thủ công
        vim.lsp.enable(server)
      end

      -- 3. Cấu hình riêng cho Lua (cho NixOS)
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        cmd = { "/run/current-system/sw/bin/lua-language-server" },
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
      vim.lsp.enable("lua_ls")

      -- 4. Keymaps (Dùng LspAttach event để gán phím khi LSP chạy)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
 }

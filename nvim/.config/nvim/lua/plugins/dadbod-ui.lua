return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- 1. Giao diện (UI) hiện đại
			vim.g.db_ui_use_nerd_fonts = 1 -- Dùng icon (cần Nerd Font trên NixOS)
			vim.g.db_ui_show_database_navigation = 1 -- Hiện bảng, cột rõ ràng
			vim.g.db_ui_winwidth = 35 -- Độ rộng sidebar vừa phải
			vim.g.db_ui_auto_execute_table_helpers = 1 -- Click vào bảng là hiện data luôn

			-- Tự động thực thi khi click vào table (xem 100 dòng đầu)
			vim.g.db_ui_table_helpers = {
				postgresql = { List = 'SELECT * FROM "{table}" LIMIT 100' },
				mysql = { List = "SELECT * FROM `{table}` LIMIT 100" },
				sqlserver = { List = "SELECT TOP 100 * FROM {table}" },
			}
			-- 2. Bảo mật & Đồng bộ (Quan trọng cho dự án công ty)
			-- Không lưu pass vào lịch sử command
			vim.g.db_ui_save_queries_state_control = 1

			-- Trỏ nơi lưu các file SQL truy vấn (nên để trong folder dự án hoặc folder riêng)
			-- vim.g.db_ui_tmp_query_location = '~/queries/work'

			-- 3. Phím tắt nhanh ngay trong file này
			vim.keymap.set("n", "<leader>du", "<cmd>DBUIToggle<cr>", { desc = "Toggle DB UI" })
			vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find DB Buffer" })
			vim.keymap.set("n", "<leader>dr", "<cmd>DBUIReload<cr>", { desc = "Reload DB Connections" })
		end,
		config = function()
			-- 4. Tự động kích hoạt gợi ý code (Autocomplete)
			-- Tích hợp thẳng vào nvim-cmp khi bạn mở file SQL
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					})
				end,
			})
		end,
	},
}

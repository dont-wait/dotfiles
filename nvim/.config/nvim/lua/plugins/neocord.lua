return {
	"IogaMaster/neocord",
	event = "VeryLazy",
	config = function()
		require("neocord").setup({
			logo = "https://neovim.io/logos/neovim-mark.png",
			logo_tooltip = "Neovim - The Hyperextensible Editor",

			editing_text = "Working on %s", -- Đang xử lý file...
			file_explorer_text = "Browsing %s", -- Đang duyệt file...
			git_commit_text = "Committing changes", -- Đang commit...
			plugin_manager_text = "Managing plugins", -- Đang quản lý plugin...
			reading_text = "Reading %s", -- Đang đọc tài liệu/code...
			workspace_text = "Project: %s", -- Tên dự án

			show_time = true,
			global_timer = true,
			line_number = false, -- Tắt số dòng cho đỡ rối
			idle_timeout = 600000, -- 10 phút không gõ thì ẩn (cho chuyên nghiệp)

			-- === Bảo mật ===
			blacklist = {"work"},

			buttons = {
				{
					label = "View Config",
					url = "https://github.com/dontwait/dotfiles", -- Đổi thành link dotfiles của bạn
				},
			},
		})
	end,
}

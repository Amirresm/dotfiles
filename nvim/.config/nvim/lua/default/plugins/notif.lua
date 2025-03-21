return {
	"j-hui/fidget.nvim",
	opts = {
		-- Options related to notification subsystem
		notification = {
			-- Options related to the notification window and buffer
			window = {
				normal_hl = "Comment", -- Base highlight group in the notification window
				winblend = 0, -- Background color opacity in the notification window
				border = "single", -- Border around the notification window
				zindex = 45, -- Stacking priority of the notification window
				max_width = 0, -- Maximum width of the notification window
				max_height = 0, -- Maximum height of the notification window
				x_padding = 1, -- Padding from right edge of window boundary
				y_padding = 0, -- Padding from bottom edge of window boundary
				align = "bottom", -- How to align the notification window
				relative = "editor", -- What the notification window position is relative to
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- stages = "",
				timeout = 3000,
                max_width = 50,
                render = "wrapped-compact",
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			})
			vim.notify = require("notify")
		end,
	},
}

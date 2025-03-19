return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		focus_on_close = "previous",
		insert_at_end = true,
		semantic_letters = false,
		sidebar_filetypes = {
			NvimTree = {
				text = "File Tree",
				align = "center",
			},
			undotree = {
				text = "undotree",
				align = "center",
			},
		},
		highlight_alternate = true,
		highlight_inactive_file_icons = false,
		highlight_alternate_file_icons = true,
		highlight_visible = true,

		icons = {
			buffer_index = false,
			buffer_number = false,
			button = "",
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true },
				[vim.diagnostic.severity.WARN] = { enabled = true },
				[vim.diagnostic.severity.INFO] = { enabled = true },
				[vim.diagnostic.severity.HINT] = { enabled = true },
			},
			gitsigns = {
				added = { enabled = true, icon = "+" },
				changed = { enabled = true, icon = "~" },
				deleted = { enabled = true, icon = "-" },
			},
			filetype = {
				enabled = true,
			},

			separator = { left = "▎", right = "" },
			separator_at_end = true,

			modified = { button = "●" },
			pinned = { button = "", filename = true },

			preset = "default",

			alternate = { filetype = { enabled = true } },
			current = { buffer_index = true },
			inactive = { button = "×" },
			visible = { modified = { buffer_number = false } },
		},
	},
}

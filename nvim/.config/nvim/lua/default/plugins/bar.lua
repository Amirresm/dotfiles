return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	opts = {
		-- auto_hide = 1,
		focus_on_close = "previous",
		-- highlight_alternate = false,
		-- highlight_inactive_file_icons = false,
		-- highlight_visible = true,
		insert_at_end = true,
		semantic_letters = false,
		sidebar_filetypes = {
			NvimTree = true,
			undotree = {
				text = "undotree",
				align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
			},
		},
	},
}

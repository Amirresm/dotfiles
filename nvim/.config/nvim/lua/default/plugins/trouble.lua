return {
	"folke/trouble.nvim",
	opts = {
		modes = {
			diagnostics = {
				win = {
					size = 0.3,
				},
			},
			symbols = {
				win = {
					size = 0.25,
				},
			},
		},
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>lD",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>ld",
			"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>ls",
			"<cmd>Trouble symbols toggle focus=true<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>ll",
			"<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>lL",
			"<cmd>Trouble loclist toggle focus=true<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>la",
			"<cmd>Trouble qflist toggle focus=true<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}

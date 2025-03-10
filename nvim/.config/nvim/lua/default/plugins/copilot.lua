return {
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	event = "InsertEnter",
	-- 	dependencies = { "zbirenbaum/copilot.lua" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
	-- 			require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
	-- 		end, 100)
	-- 	end,
	-- }
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-\\>"
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<M-CR>",
						accept_word = "<M-l>",
						accept_line = "<M-j>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = 'node', -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	}
}

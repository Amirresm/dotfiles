lvim.plugins = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		'wfxr/minimap.vim',
		build = "cargo install --locked code-minimap",
		-- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
		config = function()
			vim.cmd("let g:minimap_width = 10")
			vim.cmd("let g:minimap_auto_start = 1")
			vim.cmd("let g:minimap_auto_start_win_enter = 1")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require('neoscroll').setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
					'<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
				hide_cursor = true,  -- Hide cursor while scrolling
				stop_eof = true,     -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = "sine", -- Default easing function
				pre_hook = nil,      -- Function to run before the scrolling animation starts
				post_hook = nil,     -- Function to run after the scrolling animation ends
			})
		end
	},
	-- {
	--   "folke/persistence.nvim",
	--   event = "BufReadPre", -- this will only start session saving when an actual file was opened
	--   -- module = "persistence",
	--   lazy = true,
	--   config = function()
	--     require("persistence").setup {
	--       dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
	--       options = { "buffers", "curdir", "tabpages", "winsize" },
	--     }
	--   end,
	-- },
	{
		"tpope/vim-surround",

		-- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
		-- setup = function()
		--  vim.o.timeoutlen = 500
		-- end
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
				require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
			end, 100)
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require('goto-preview').setup {
				width = 120,     -- Width of the floating window
				height = 25,     -- Height of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false,   -- Print debug information
				opacity = nil,   -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
				-- You can use "default_mappings = true" setup option
				-- Or explicitly set keybindings
				-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
				-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
				-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
			}
		end
	},
	{
		"jeffkreeftmeijer/vim-numbertoggle"
	},
}

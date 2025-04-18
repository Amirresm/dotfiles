-- lvim.lsp.null_ls = nil
lvim.plugins = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require('neoscroll').setup({
				mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
					'<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = "sine", -- Default easing function
				pre_hook = nil,  -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
		end
	},
	{
		"tpope/vim-surround",
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
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
			}
		end
	},
	{
		"jeffkreeftmeijer/vim-numbertoggle"
	},
	{
		"brenoprata10/nvim-highlight-colors"
	},
	{
		"nvimtools/none-ls.nvim"
	},
	{
		"sindrets/diffview.nvim"
	},
	{
		"FabijanZulj/blame.nvim",
		opts = {
			blame_options = { '-w' },
		},
	},
	-- {
	-- 	'danilamihailov/beacon.nvim'
	-- },
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require 'lsp_signature'.setup(opts) end
	},
	{
		'kevinhwang91/nvim-ufo',
		dependencies = "kevinhwang91/promise-async"
	},
	{
		'rmagatti/auto-session',
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			-- suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
			-- log_level = 'debug',
		}
	},

	-- COLORSCHEME
	{
		"Abstract-IDE/Abstract-cs"
	},
	{
		"rafamadriz/neon"
	},
	{
		"comfysage/evergarden"
	},
	{
		"nyoom-engineering/oxocarbon.nvim"
	},
	{
		'sainnhe/everforest',
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = 'hard'
		end
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{ "towolf/vim-helm", ft = "helm" }
}

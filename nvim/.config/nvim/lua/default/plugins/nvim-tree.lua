return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({})

		-- auto-session fix
		vim.api.nvim_create_autocmd({ 'BufEnter' }, {
			pattern = 'NvimTree*',
			callback = function()
				local api = require('nvim-tree.api')
				local view = require('nvim-tree.view')

				if not view.is_visible() then
					api.tree.open()
				end
			end,
		})

		-- Make :bd and :q behave as usual when tree is visible
		vim.api.nvim_create_autocmd({ 'BufEnter', 'QuitPre' }, {
			nested = false,
			callback = function(e)
				local tree = require('nvim-tree.api').tree

				-- Nothing to do if tree is not opened
				if not tree.is_visible() then
					return
				end

				-- How many focusable windows do we have? (excluding e.g. incline status window)
				local winCount = 0
				for _, winId in ipairs(vim.api.nvim_list_wins()) do
					if vim.api.nvim_win_get_config(winId).focusable then
						winCount = winCount + 1
					end
				end

				-- We want to quit and only one window besides tree is left
				if e.event == 'QuitPre' and winCount == 2 then
					vim.api.nvim_cmd({ cmd = 'qall' }, {})
				end

				-- :bd was probably issued an only tree window is left
				-- Behave as if tree was closed (see `:h :bd`)
				if e.event == 'BufEnter' and winCount == 1 then
					-- Required to avoid "Vim:E444: Cannot close last window"
					vim.defer_fn(function()
						-- close nvim-tree: will go to the last buffer used before closing
						tree.toggle({ find_file = true, focus = true })
						-- re-open nivm-tree
						tree.toggle({ find_file = true, focus = false })
					end, 10)
				end
			end
		})
	end,
}

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--follow", -- Follow symbolic links
				"--hidden", -- Search for hidden files
				"--no-heading", -- Don't group matches by each file
				"--with-filename", -- Print the file path with the matched lines
				"--line-number", -- Show line numbers
				"--column", -- Show column numbers
				"--smart-case", -- Smart case search

				"--glob=!**/.git/*",
				"--glob=!**/.idea/*",
				"--glob=!**/.vscode/*",
				"--glob=!**/build/*",
				"--glob=!**/dist/*",
				"--glob=!**/yarn.lock",
				"--glob=!**/package-lock.json",
			},
			file_ignore_patterns = { "node_modules", "vendor", ".*\\.lock", "package-lock.json" },
			mappings = {
				i = {
					["<C-u>"] = false,
				},
			},
			preview = {
				filesize_limit = 1, -- MB
			},
		},
		pickers = {
			find_files = {
				hidden = true,
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--glob=!**/.git/*",
					"--glob=!**/.idea/*",
					"--glob=!**/.vscode/*",
					"--glob=!**/build/*",
					"--glob=!**/dist/*",
					"--glob=!**/yarn.lock",
					"--glob=!**/package-lock.json",
				},
			},
		},
	},
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
	{
		command = "flake8",
		filetypes = { "python" },
		extra_args = { "--max-line-length=120" }
	}
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{
		name = "black",
		extra_args = { "--fast", "--preview", "--line-length", "80" },
	},
}

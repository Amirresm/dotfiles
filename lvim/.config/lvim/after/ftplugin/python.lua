local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{ name = "black" },
}

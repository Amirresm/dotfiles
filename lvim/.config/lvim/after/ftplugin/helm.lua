-- set prettier as the formatter with null-ls
local null_ls = require("null-ls")
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.prettier,
	},
}


local lspconfig = require('lspconfig')

lspconfig.helm_ls.setup {
	settings = {
		['helm-ls'] = {
			yamlls = {
				path = "yaml-language-server",
			}
		}
	}
}

vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("set expandtab")
vim.cmd("set smartindent")
vim.cmd("set smarttab")

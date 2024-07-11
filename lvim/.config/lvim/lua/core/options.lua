lvim.colorscheme = "catppuccin-mocha"
lvim.transparent_window = true

vim.opt.colorcolumn = "80"

vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set noexpandtab")
vim.cmd("set smartindent")
vim.cmd("set smarttab")

vim.cmd("set conceallevel=0")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
	}
)

if vim.fn.has("wsl") == 1 then
	if vim.fn.executable("win32yank.exe") == 0 then
		print("win32yank not found, clipboard integration won't work")
	else
		vim.g.clipboard = {
			name = "win32yank (wsl)",
			copy = {
				["+"] = 'win32yank.exe -i --crlf',
				["*"] = 'win32yank.exe -i --crlf',
			},
			paste = {
				["+"] = 'win32yank.exe -o --lf',
				["*"] = 'win32yank.exe -o --lf',
			},
			cache_enabled = true
		}
	end
end

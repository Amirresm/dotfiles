vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.cmd.colorscheme("rose-pine")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false -- or false

vim.opt.smartindent = true
-- vim.opt.smarttab = true

vim.opt.wrap = false

-- vim.opt.conceallevel = 0

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.pumwidth = 50
vim.opt.pumheight = 12

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.clipboard = "unnamedplus"

-- Enable diagnostic in insert mode
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	underline = true,
-- 	virtual_text = {
-- 		spacing = 5,
-- 	},
-- 	update_in_insert = true,
-- })

-- Setup windows clipboard
if vim.fn.has("wsl") == 1 then
	if vim.fn.executable("win32yank.exe") == 0 then
		print("win32yank not found, clipboard integration won't work")
	else
		vim.g.clipboard = {
			name = "win32yank (wsl)",
			copy = {
				["+"] = "win32yank.exe -i --crlf",
				["*"] = "win32yank.exe -i --crlf",
			},
			paste = {
				["+"] = "win32yank.exe -o --lf",
				["*"] = "win32yank.exe -o --lf",
			},
			cache_enabled = true,
		}
	end
end

-- Diff buffer with original file
vim.api.nvim_create_user_command("Difforig", function()
	local scratch_buffer = vim.api.nvim_create_buf(false, true)
	local current_ft = vim.bo.filetype
	vim.cmd("vertical sbuffer" .. scratch_buffer)
	vim.bo[scratch_buffer].filetype = current_ft
	vim.cmd("read ++edit #") -- load contents of previous buffer into scratch_buffer
	vim.cmd.normal('1G"_d_') -- delete extra newline at top of scratch_buffer without overriding register
	vim.cmd.diffthis() -- scratch_buffer
	vim.cmd.wincmd("p")
	vim.cmd.diffthis() -- current buffer
end, {})

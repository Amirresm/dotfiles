lvim.colorscheme = "catppuccin-mocha"
-- lvim.colorscheme = "oxocarbon"
-- lvim.colorscheme = "evergarden"
--
-- lvim.transparent_window = true
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

local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
-- local api = vim.api
-- local M = {}
-- -- function to create a list of commands and convert them to autocommands
-- -------- This function is taken from https://github.com/norcalli/nvim_utils
-- function M.nvim_create_augroups(definitions)
--     for group_name, definition in pairs(definitions) do
--         api.nvim_command('augroup '..group_name)
--         api.nvim_command('autocmd!')
--         for _, def in ipairs(definition) do
--             local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
--             api.nvim_command(command)
--         end
--         api.nvim_command('augroup END')
--     end
-- end


-- local autoCommands = {
--     -- other autocommands
--     open_folds = {
--         {"BufReadPost,FileReadPost", "*", "normal zR"}
--     }
-- }

-- M.nvim_create_augroups(autoCommands)

vim.api.nvim_create_user_command('Difforig', function()
      local scratch_buffer = vim.api.nvim_create_buf(false, true)
      local current_ft = vim.bo.filetype
      vim.cmd('vertical sbuffer' .. scratch_buffer)
      vim.bo[scratch_buffer].filetype = current_ft
      vim.cmd('read ++edit #') -- load contents of previous buffer into scratch_buffer
      vim.cmd.normal('1G"_d_') -- delete extra newline at top of scratch_buffer without overriding register
      vim.cmd.diffthis() -- scratch_buffer
      vim.cmd.wincmd('p')
      vim.cmd.diffthis() -- current buffer
end, {})


local opts = { noremap = true, silent = true }

-- Which Key Groups
local wk = require("which-key")
local moveline = require("moveline")

wk.add({
	{
		{ "<leader>w", "<cmd>w<cr>", desc = "Save" },
		{ "<leader>W", "<cmd>wa<cr>", desc = "Save All" },
		{ "<leader>q", "<cmd>q<cr>", desc = "Quit" },
		{ "<leader>Q", "<cmd>qa<cr>", desc = "Quit All" },
		{ "<leader>z", "<cmd>xa<cr>", desc = "Save and Quit" },

		{ "<leader>h", "<cmd>nohlsearch<cr>", desc = "Clear Highlighting" },

		{ "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle File Explorer" },
		{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undo Tree" },

		-- Set in lua/default/plugins/toggleterm.lua
		-- { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal" },

		{ "<C-p>", '"0p', desc = "Paste from clipboard" },
		{ "<C-S-p>", '"+p', desc = "Paste from clipboard" },

		{ "<C-l>", "<C-w>l", desc = "Right Window" },
		{ "<C-h>", "<C-w>h", desc = "Left Window" },
		{ "<C-k>", "<C-w>k", desc = "Top Window" },
		{ "<C-j>", "<C-w>j", desc = "Bottom Window" },

		{ "<C-Up>", "<Cmd>resize +2<CR>", desc = "Increase Height" },
		{ "<C-Down>", "<Cmd>resize -2<CR>", desc = "Decrease Height" },
		{ "<C-Left>", "<Cmd>vertical resize -2<CR>", desc = "Decrease Width" },
		{ "<C-Right>", "<Cmd>vertical resize +2<CR>", desc = "Increase Width" },

		{ "<M-k>", moveline.up, mode = "n", desc = "Move Line Up" },
		{ "<M-j>", moveline.down, mode = "n", desc = "Move Line Up" },
		{ "<M-k>", moveline.block_up, mode = "v", desc = "Move Line Up" },
		{ "<M-j>", moveline.block_down, mode = "v", desc = "Move Line Up" },

		{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find File" },
		{ "<leader>n", "<cmd>Telescope notify<cr>", desc = "Notifications" },

		{ "<leader>/", "gcc", desc = "Toggle Comment", remap = true },
		{ "<leader>/", "gc", desc = "Toggle Comment", mode = { "v" }, remap = true },
	},
	{
		{ "<leader>s", group = "Search" },
		{ "<leader>ss", "<cmd>Telescope resume<cr>", desc = "Continue Last Search" },
		{ "<leader>sg", "<cmd>Telescope git_files<cr>", desc = "Find Git" },
		{ "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
		{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Find Under cursor", mode = { "n", "v" } },
		{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
		{ "<leader>sp", "<cmd>Telescope commands<cr>", desc = "Find Command" },
		{ "<leader>s?", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
		{ "<leader>s$", "<cmd>Telescope marks<cr>", desc = "Marks" },
		{ "<leader>s%", "<cmd>Telescope registers<cr>", desc = "Registers" },
		{ "<leader>;", "<cmd>Telescope oldfiles<cr>", desc = "Old Files" },
	},
	{
		{ "<leader>b", group = "Buffer" },
		{ "<leader>bl", "<Cmd>buffer #<CR>", opts },
		-- Move to previous/next
		{ "<leader>bb", "<Cmd>BufferPrevious<CR>", opts },
		{ "<leader>bn", "<Cmd>BufferNext<CR>", opts },

		-- Re-order to previous/next
		{ "<leader>b<", "<Cmd>BufferMovePrevious<CR>", opts },
		{ "<leader>b>", "<Cmd>BufferMoveNext<CR>", opts },

		-- Goto buffer in position...
		{ "<leader>b1", "<Cmd>BufferGoto 1<CR>", opts },
		{ "<leader>b2", "<Cmd>BufferGoto 2<CR>", opts },
		{ "<leader>b3", "<Cmd>BufferGoto 3<CR>", opts },
		{ "<leader>b4", "<Cmd>BufferGoto 4<CR>", opts },
		{ "<leader>b5", "<Cmd>BufferGoto 5<CR>", opts },
		{ "<leader>b6", "<Cmd>BufferGoto 6<CR>", opts },
		{ "<leader>b7", "<Cmd>BufferGoto 7<CR>", opts },
		{ "<leader>b8", "<Cmd>BufferGoto 8<CR>", opts },
		{ "<leader>b9", "<Cmd>BufferGoto 9<CR>", opts },
		{ "<leader>b0", "<Cmd>BufferLast<CR>", opts },

		-- Pin/unpin buffer
		{ "<leader>bp", "<Cmd>BufferPin<CR>", opts },

		-- Close buffer
		{ "<leader>bx", "<Cmd>BufferClose<CR>", opts },
		{ "<leader>bo", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", desc = "Close all other windows" },

		-- Magic buffer-picking mode
		{ "<leader>bj", "<Cmd>BufferPick<CR>", opts },
		{ "<leader>bc", "<Cmd>BufferPickDelete<CR>", opts },

		-- Sort automatically by...
		{ "<leader>bs", group = "Buffer Sort" },
		{ "<leader>bsb", "<Cmd>BufferOrderByBufferNumber<CR>", opts },
		{ "<leader>bsn", "<Cmd>BufferOrderByName<CR>", opts },
		{ "<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>", opts },
		{ "<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>", opts },
		{ "<leader>bsw", "<Cmd>BufferOrderByWindowNumber<CR>", opts },
	},
	{
		{ "<leader>l", group = "LSP" },
		{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename Symbol" },
		{ "<leader>lR", "<Cmd>LspRestart<CR>", desc = "Reload Lsp" },
		{
			"<leader>li",
			"<Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })<CR>",
			desc = "Toggle Inlay Hints",
		},
		{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
		-- { "<leader>la", vim.lsp.buf.format, desc = "Format buffer", mode = { "n", "v" } },
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
			mode = { "n", "v" },
		},
        { "<leader>lt", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, desc = "Toggle Diagnostics" },
		{ "<leader>lm", vim.diagnostic.open_float, desc = "Show Line Diagnostics" },
		{ "<leader>lk", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
		{ "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
		{ "<C-S-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
		{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
		{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
		{ "gr", vim.lsp.buf.references, desc = "Show References" },
		{ "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
		-- Diagnostic is defined in lua/default/plugins/trouble.lua
		-- {
		-- 	"<leader>/",
		-- 	function()
		-- 		require("Comment.api").toggle.linewise.current()
		-- 	end,
		-- 	desc = "Toggle Comment (Normal Mode)",
		-- },
		-- {
		-- 	"<leader>/",
		-- 	function()
		-- 		require("Comment.api").toggle.linewise(vim.fn.visualmode())
		-- 	end,
		-- 	mode = "v",
		-- 	desc = "Toggle Comment (Visual Mode)",
		-- },
	},
	{
		{ "<leader>g", group = "Git" },
		{ "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "Blame" },
	},
	{
		{ "<leader>p", group = "Session" },
		{ "<leader>ps", "<cmd>SessionSave<cr>", desc = "Save Session" },
		{ "<leader>pl", "<cmd>SessionSearch<cr>", desc = "Load Session" },
	},
	{
		{ "<leader>d", group = "Debugger" },
		{ "<leader>du", '<cmd>lua require"dapui".toggle()<CR>', desc = "Debug: Toggle UI" },
		-- Set in lua/default/plugins/dap.lua
	},
	-- some cool stuff copied from internet
	{
		{ "<leader>t", group = "Utils" },
		{ "<leader>ts", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "substitute word under cursor", mode = "n" },
        { "<leader>ts", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "substitute word under cursor", mode = "v" },
        { "<leader>tx", "<cmd>!chmod +x %<CR>", desc = "Make file executable" },
		{ "<leader>tx", "<cmd>!chmod +x %<CR>", { silent = true }, desc = "Make file executable" },
	},
})

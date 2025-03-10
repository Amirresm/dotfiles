-- local cmp_r = require("cmp")
lvim.builtin.cmp.window = {
	completion = {
		border = "rounded",
		winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
		col_offset = -3,
		side_padding = 1,
		-- scrollbar = false,
		-- scrollbar = {
		--   position = 'inside',
		-- },
		scrolloff = 8,
	},
	documentation = {
		border = "rounded",
		-- winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
	},
}

-- lvim.builtin.cmp.sources = {
-- 	{ name = "copilot",    group_index = 2 },
-- 	{ name = "nvim_lsp",   group_index = 2 },
-- 	{ name = "buffer",     group_index = 2 },
-- 	{ name = "path",       group_index = 2 },
-- 	{ name = "luasnip",    group_index = 2 },
-- 	{ name = "treesitter", group_index = 2 },
-- }

-- lvim.builtin.cmp.sorting = {
-- 	priority_weight = 2,
-- 	comparators = {
-- 		require("copilot_cmp.comparators").prioritize,

-- 		-- Below is the default comparitor list and order for nvim-cmp
-- 		cmp_r.config.compare.offset,
-- 		-- cmp_r.config.compare.scopes, --this is commented in nvim-cmp too
-- 		cmp_r.config.compare.exact,
-- 		cmp_r.config.compare.score,
-- 		cmp_r.config.compare.recently_used,
-- 		cmp_r.config.compare.locality,
-- 		cmp_r.config.compare.kind,
-- 		cmp_r.config.compare.sort_text,
-- 		cmp_r.config.compare.length,
-- 		cmp_r.config.compare.order,
-- 	},
-- }

-- cmp setup

-- local cmp = require("cmp")

-- local has_words_before = function()
-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end
-- cmp.setup({
-- 	window = {
-- 		completion = {
-- 			border = "rounded",
-- 			winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
-- 			col_offset = -3,
-- 			side_padding = 1,
-- 			-- scrollbar = false,
-- 			-- scrollbar = {
-- 			--   position = 'inside',
-- 			-- },
-- 			scrolloff = 8,
-- 		},
-- 		documentation = {
-- 			border = "rounded",
-- 			-- winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
-- 		},

-- 	},
-- 	-- mapping = {
-- 		-- ["<Tab>"] = vim.schedule_wrap(function(fallback)
-- 		-- 	if cmp.visible() and has_words_before() then
-- 		-- 		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
-- 		-- 	else
-- 		-- 		fallback()
-- 		-- 	end
-- 		-- end),
-- 	-- },
-- 	-- sorting = {
-- 	-- 	priority_weight = 2,
-- 	-- 	comparators = {
-- 	-- 		require("copilot_cmp.comparators").prioritize,

-- 	-- 		-- Below is the default comparitor list and order for nvim-cmp
-- 	-- 		cmp.config.compare.offset,
-- 	-- 		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
-- 	-- 		cmp.config.compare.exact,
-- 	-- 		cmp.config.compare.score,
-- 	-- 		cmp.config.compare.recently_used,
-- 	-- 		cmp.config.compare.locality,
-- 	-- 		cmp.config.compare.kind,
-- 	-- 		cmp.config.compare.sort_text,
-- 	-- 		cmp.config.compare.length,
-- 	-- 		cmp.config.compare.order,
-- 	-- 	},
-- 	-- },
-- })

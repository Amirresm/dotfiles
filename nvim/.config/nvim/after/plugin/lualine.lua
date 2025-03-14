local get_active_lsp = function()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_get_option_value("filetype", {})
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(clients) == nil then
		return msg
	end

	local active_clients = {}
	for _, client in ipairs(clients) do
		---@diagnostic disable-next-line: undefined-field
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			table.insert(active_clients, client.name)
		end
	end
	return table.concat(active_clients, ", ")
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			"filename",
			-- function()
			-- 	return require("auto-session.lib").current_session_name(true)
			-- end,
		},
		lualine_x = {
            "copilot",
			{
				get_active_lsp,
				-- icon = "📡",
			},
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

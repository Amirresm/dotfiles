require('evergarden').setup {
	transparent_background = false,
	contrast_dark = 'hard', -- 'hard'|'medium'|'soft'
	override_terminal = true,
	style = {
		tabline = { reverse = true, color = 'green' },
		search = { reverse = false, inc_reverse = true },
		types = { italic = true },
		keyword = { italic = true },
		comment = { italic = false },
		sign = { highlight = false },
	},
	overrides = {
		Folded = { bg = '#1c2b28' },
		FoldColumn = { fg = '#8a5b00' },
		-- fold = { bg = 'red' },
	}, -- add custom overrides
}

local M = {}

M.colors = {
	dark0 = '#181818',
	dark1 = '#3c3836',
	dark2 = '#504945',
	dark3 = '#665c54',
	dark4 = '#7c6f64',
	light0 = '#fbf1c7',
	light1 = '#ebdbb2',
	light2 = '#d5c4a1',
	light3 = '#bdae93',
	light4 = '#a89984',
	bright_red = '#ea6962',
	bright_green = '#a9b665',
	bright_yellow = '#d8a657',
	bright_blue = '#7daea3',
	bright_purple = '#d3869b',
	bright_aqua = '#89b482',
	bright_orange = '#e78a4e',
	neutral_red = '#ea6962',
	neutral_green = '#a9b665',
	neutral_yellow = '#d8a657',
	neutral_blue = '#7daea3',
	neutral_purple = '#d3869b',
	neutral_aqua = '#89b482',
	neutral_orange = '#e78a4e',
	faded_red = '#9d0006',
	faded_green = '#79740e',
	faded_yellow = '#b57614',
	faded_blue = '#076678',
	faded_purple = '#8f3f71',
	faded_aqua = '#427b58',
	faded_orange = '#af3f03',
}

M.get_base_colors = function(bg)
	local p = M.colors

	if bg == nil then
		bg = vim.o.background
	end

	local colors = {
		dark = {
			bg0 = p.dark0,
			bg1 = p.dark1,
			bg2 = p.dark2,
			bg3 = p.dark3,
			bg4 = p.dark4,
			fg0 = p.light0,
			fg1 = p.light1,
			fg2 = p.light2,
			fg3 = p.light3,
			fg4 = p.light4,
			red = p.bright_red,
			green = p.bright_green,
			yellow = p.bright_yellow,
			blue = p.bright_blue,
			purple = p.bright_purple,
			aqua = p.bright_aqua,
			orange = p.bright_orange,
			neutral_red = p.neutral_red,
			neutral_green = p.neutral_green,
			neutral_yellow = p.neutral_yellow,
			neutral_blue = p.neutral_blue,
			neutral_purple = p.neutral_purple,
			neutral_aqua = p.neutral_aqua,
			gray = p.dark4,
			visual = '#442e2d',
			color_column = '#141414'
		},
		light = {
			bg0 = "#ffffff",
			bg1 = "#d6d6d6",
			bg2 = "#c9c9c9",
			bg3 = "#aaaaaa",
			bg4 = "#878787",
			fg0 = p.dark0,
			fg1 = p.dark1,
			fg2 = p.dark2,
			fg3 = p.dark3,
			fg4 = p.dark4,
			red = p.faded_red,
			green = p.faded_green,
			yellow = p.faded_yellow,
			blue = p.faded_blue,
			purple = p.faded_purple,
			aqua = p.faded_aqua,
			orange = p.faded_orange,
			neutral_red = p.neutral_red,
			neutral_green = p.neutral_green,
			neutral_yellow = p.neutral_yellow,
			neutral_blue = p.neutral_blue,
			neutral_purple = p.neutral_purple,
			neutral_aqua = p.neutral_aqua,
			gray = p.light4,
			visual = '#f0ddc3',
			color_column = '#f5f5f5'
		},
	}

	return colors[bg]
end

return M

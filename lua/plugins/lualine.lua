local function get_search_count()
	local result = vim.fn.searchcount { maxcount = 99999 }
	if result.total > 0 then
		return string.format('[%d / %d]', result.current, result.total)
	end
	return ''
end

local function already_contained(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

local function attached_servers()
	local names = {}
	for i, server in pairs(vim.lsp.buf_get_clients(0)) do
		if not already_contained(names, server.name) then
			table.insert(names, server.name)
		end
	end
	if #names == 0 then
		return ''
	end
	return '[' .. table.concat(names, ' ') .. ']'
end

local colors_dark = {
	black = '#282828',
	white = '#ebdbb2',
	red = '#bd5752',
	blue = '#62a0ea',
	green = '#89b482',
	yellow = '#e5a50a',
	gray = '#a89984',
	darkgray = '#3c3836',
	lightgray = '#504945',
	inactivegray = '#7c6f64',
}

local colors_light = {
	black = '#3c3836',
	white = '#f9f5d7',
	red = '#bd5752',
	blue = '#62a0ea',
	green = '#427b58',
	yellow = '#e5a50a',
	gray = '#a89984',
	lightgray = '#7c6f64',
	darkgray = '#ebdbb2',
	inactivegray = '#a89984',
}

local get_theme = function(colors)
	return {
		normal = {
			a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
		insert = {
			a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
		visual = {
			a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
		replace = {
			a = { bg = colors.red, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
		command = {
			a = { bg = colors.green, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
		inactive = {
			a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
			b = { bg = colors.darkgray, fg = colors.gray },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
	}
end

local ternary = function(cond, T, F)
	if cond then
		return T
	else
		return F
	end
end

return {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	opts = function()
		local navic = require 'nvim-navic'
		local theme = get_theme(ternary(vim.api.nvim_get_option 'background' == 'light', colors_light, colors_dark))
		return {
			options = {
				theme = theme,
				component_separators = '|',
				section_separators = { left = '', right = '' },
			},
			sections = {
				lualine_a = { { 'mode', lowercase = false } },
				lualine_b = {
					{ require('auto-session.lib').current_session_name },
					{ 'branch', { 'diff', colored = false } },
				},
				lualine_c = {
					{
						function()
							return navic.get_location()
						end,
						cond = function()
							return navic.is_available()
						end,
					},
				},
				lualine_x = {
					{
						'diagnostics',
						colored = false,
						symbols = { error = 'E: ', warn = 'W: ', info = 'I: ', hint = 'H: ' },
					},
					attached_servers,
				},
				lualine_y = { get_search_count },
				lualine_z = { 'selectioncount', 'location', 'progress' },
			},
		}
	end,
	dependencies = {
		'nvim-tree/nvim-web-devicons',
		'SmiteshP/nvim-navic',
	},
}

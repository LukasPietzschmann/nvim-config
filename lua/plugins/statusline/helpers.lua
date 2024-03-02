local utils = LazyRequire 'heirline.utils'

M = {}

M.Space = setmetatable({ provider = ' ' }, {
	__call = function(_, n)
		return { provider = string.rep(' ', n) }
	end,
})

M.Empty = { provider = '' }

M.Fill = { provider = '%=' }

M.Divider = { provider = ' | ' }

M.icons = {
	tools = {
		formatter = '󰉼',
		language_servers = ' ',
		linters = '󰍉',
		parsers = '󰹩',
	},
	copilot = {
		enabled = ' ',
		sleep = ' ',
		disabled = ' ',
		warning = ' ',
		unknown = ' ',
	},
	powerline = {
		vertical_bar_thin = '│',
		vertical_bar = '┃',
		block = '█',
		----------------------------------------------
		slant_left = '',
		slant_left_thin = '',
		slant_right = '',
		slant_right_thin = '',
		----------------------------------------------
		slant_left_2 = '',
		slant_left_2_thin = '',
		slant_right_2 = '',
		slant_right_2_thin = '',
		----------------------------------------------
		left_rounded = '',
		left_rounded_thin = '',
		right_rounded = '',
		right_rounded_thin = '',
		----------------------------------------------
		trapezoid_left = '',
		trapezoid_right = '',
	},
	padlock = '',
	circle_small = '●', -- ●
	circle = '', -- 
	circle_plus = '', -- 
	dot_circle_o = '', -- 
	circle_o = '⭘', -- ⭘
}

local function already_contained(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function M.insert_set(tab, elem)
	if already_contained(tab, elem) then
		return
	end
	table.insert(tab, elem)
end

function M.surround(delimiters, color, bgl, bgr, component)
	component = utils.clone(component)

	local surround_color = function(self)
		if type(color) == 'function' then
			return color(self)
		else
			return color
		end
	end

	return {
		{
			provider = delimiters[1],
			hl = function(self)
				local s_color = surround_color(self)
				if s_color then
					return { fg = s_color, bg = bgl }
				end
			end,
		},
		{
			hl = function(self)
				local s_color = surround_color(self)
				if s_color then
					return { bg = s_color }
				end
			end,
			component,
		},
		{
			provider = delimiters[2],
			hl = function(self)
				local s_color = surround_color(self)
				if s_color then
					return { fg = s_color, bg = bgr }
				end
			end,
		},
	}
end

function M.truncate(str, len)
	if #str > len then
		return str:sub(1, len - 1) .. '…'
	end
	return str
end

return M

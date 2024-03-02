local utils = lazy_require 'heirline.utils'

Space = setmetatable({ provider = ' ' }, {
	__call = function(_, n)
		return { provider = string.rep(' ', n) }
	end,
})

Empty = { provider = '' }

Fill = { provider = '%=' }

Divider = { provider = ' | ' }

function surround(delimiters, color, bgl, bgr, component)
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

function truncate(str, len)
	if #str > len then
		return str:sub(1, len - 1) .. '…'
	end
	return str
end

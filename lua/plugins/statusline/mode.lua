local mode_names = {
	n = 'Normal',
	no = 'Normal?',
	nov = 'Normal?',
	noV = 'Normal?',
	['no\22'] = 'Normal?',
	niI = 'NormalI',
	niR = 'NormalR',
	niV = 'NormalV',
	nt = 'NormalT',
	v = 'VisualC',
	vs = 'VisualCS',
	V = 'VisualL',
	Vs = 'VisualLS',
	['\22'] = 'VisualB',
	['\22s'] = 'VisualBS',
	s = 'SelectC',
	S = 'SelectL',
	['\19'] = 'SelectB',
	i = 'Insert',
	ic = 'InsertC',
	ix = 'InsertC',
	R = 'Replace',
	Rc = 'ReplaceC',
	Rx = 'ReplaceC',
	Rv = 'ReplaceV',
	Rvc = 'ReplaceV',
	Rvx = 'ReplaceV',
	c = 'Command',
	cv = 'Ex',
	r = '...',
	rm = '...',
	['r?'] = '...',
	['!'] = '!',
	t = 'Term',
}

local mode_colors = {
	n = 'fg4',
	i = 'blue',
	v = 'yellow',
	V = 'yellow',
	['\22'] = 'yellow',
	c = 'orange',
	s = 'purple',
	S = 'purple',
	['\19'] = 'purple',
	R = 'red',
	r = 'red',
	['!'] = 'red',
	t = 'red',
}

M = {}

local ReadOnly = {
	condition = function()
		return not vim.bo.modifiable or vim.bo.readonly
	end,
	provider = icons.padlock,
}

M.Mode = {
	init = function(self)
		self.mode = vim.api.nvim_get_mode().mode
	end,
	update = { 'ModeChanged', 'BufEnter' },
	hl = { fg = 'bg0' },
	surround(
		{ icons.powerline.left_rounded, icons.powerline.right_rounded },
		function(self)
			local mode = self.mode:sub(1, 1)
			return mode_colors[mode]
		end,
		'bg0',
		nil,
		{
			{
				fallthrough = false,
				ReadOnly,
				{ provider = icons.circle },
			},
			Space,
			{
				provider = function(self)
					return mode_names[self.mode]
				end,
			},
		}
	),
}

return M

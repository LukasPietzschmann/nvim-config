return {
	'kylechui/nvim-surround',
	keys = {
		{ 'ys', mode = 'n' },
		{ 'yss', mode = 'n' },
		{ 'yS', mode = 'n' },
		{ 'ySS', mode = 'n' },
		{ 'S', mode = 'v' },
		{ 'gS', mode = 'v' },
		{ 'ds', mode = 'n' },
		{ 'cs', mode = 'n' },
		{ 'cS', mode = 'n' },
	},
	opts = {
		duration = 1,
		move_cursor = false,
		keymaps = {
			normal = 'ys',
			normal_cur = 'yss',
			normal_line = 'yS',
			normal_cur_line = 'ySS',
			visual = 'S',
			visual_line = 'gS',
			delete = 'ds',
			change = 'cs',
			change_line = 'cS',
		},
	},
}

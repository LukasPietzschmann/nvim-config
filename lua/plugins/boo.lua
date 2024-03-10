return {
	'LukasPietzschmann/boo.nvim',
	keys = {
		{ '<C-a>', function() require('boo').boo() end },
	},
	opts = {
		focus_on_open = false,
		close_on_mouse_move = true,
		win_opts = {
			title = '',
		},
	},
}

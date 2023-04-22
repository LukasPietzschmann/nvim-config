local function alpha_button(sc, txt, keybind)
	local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

	local opts = {
		position = 'center',
		text = txt,
		shortcut = sc,
		cursor = 5,
		width = 36,
		align_shortcut = 'right',
		hl = 'AlphaButtons',
	}

	if keybind then
		opts.keymap = { 'n', sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = 'button',
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, 'normal', false)
		end,
		opts = opts,
	}
end

return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	opts = function()
		local fn = vim.fn
		local marginTopPercent = 0.3
		local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

		local ascii = {
			'  ,-.       _,---._ __  / \\',
			" /  )    .-'       `./ /   \\",
			"(  (   ,'            `/    /|",
			' \\  `-"             \\\'\\   / |',
			'  `.              ,  \\ \\ /  |',
			"   /`.          ,'-`----Y   |",
			"  (            ;        |   '",
			"  |  ,-.    ,-'         |  /",
			'  |  | (   |            | /',
			'  )  |  \\  `.___________|/',
			"  `--'   `--'",
		}

		return {
			layout = {
				{ type = 'padding', val = headerPadding },
				{
					type = 'text',
					val = ascii,
					opts = {
						position = 'center',
						hl = 'AlphaHeader',
					},
				},
				{ type = 'padding', val = 2 },
				{
					type = 'group',
					val = {
						alpha_button('e', '  New File', ':enew<CR>'),
						alpha_button('s', '  Show Sessions', ':Telescope telescope-sessions search_sessions<CR>'),
						alpha_button('f', '  Find File  ', ':Telescope find_files<CR>'),
						alpha_button('r', '  Recent File  ', ':Telescope oldfiles<CR>'),
						alpha_button('i', '  Settings', ':e $MYVIMRC | :cd %:p:h <CR>'),
						alpha_button('q', 'x  Quit', ':q<CR>'),
					},
					opts = {
						spacing = 1,
					},
				},
			},
			opts = {},
		}
	end,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
}

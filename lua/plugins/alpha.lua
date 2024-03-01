local function alpha_button(sc, txt, keybind)
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
		opts.keymap = { 'n', sc, keybind, { noremap = true, silent = true } }
	end

	return {
		type = 'button',
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc, true, false, true)
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
		local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * 0.3) }

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
						alpha_button('s', '  Show Sessions', ':Telescope session-lens search_session <CR>'),
						alpha_button('e', '  New File', ':enew<CR>'),
						alpha_button('f', '  Find File  ', ':Telescope find_files<CR>'),
						alpha_button('r', '  Recent File  ', ':Telescope oldfiles<CR>'),
						alpha_button('l', '  Lazy', ':Lazy<CR>'),
						alpha_button('m', '  Mason', ':Mason<CR>'),
						alpha_button('q', '  Quit', ':q<CR>'),
					},
					opts = { spacing = 1 },
				},
			},
		}
	end,
}

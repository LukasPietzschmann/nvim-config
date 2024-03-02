local function alpha_button(sc, icon, text, keybind)
	local txt = string.format('%s %s', icon, text)
	local opts = {
		position = 'center',
		text = txt,
		shortcut = sc,
		cursor = 5,
		width = 36,
		align_shortcut = 'right',
		hl = 'AlphaButtons',
		keymap = { 'n', sc, keybind, { noremap = true, silent = true } },
	}

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
	init = function()
		vim.api.nvim_create_autocmd('User', {
			pattern = 'AlphaReady',
			desc = 'Disable spell checking for alphas buffer',
			group = vim.api.nvim_create_augroup('NospellInAlpha', { clear = true }),
			callback = function()
				vim.api.nvim_set_option_value('spell', false, { scope = 'local' })
			end,
		})
	end,
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
						alpha_button('s', icons.save, 'Show Sessions', ':Telescope session-lens search_session <CR>'),
						alpha_button('e', icons.new_file, 'New File', ':enew<CR>'),
						alpha_button('f', icons.find, 'Find File  ', ':Telescope find_files<CR>'),
						alpha_button('r', icons.clock, 'Recent File  ', ':Telescope oldfiles<CR>'),
						alpha_button('l', icons.package, 'Lazy', ':Lazy<CR>'),
						alpha_button('m', icons.grid, 'Mason', ':Mason<CR>'),
						alpha_button('q', icons.bye, 'Quit', ':q<CR>'),
					},
					opts = { spacing = 1 },
				},
			},
		}
	end,
}

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
				vim.opt_local.spell = false
			end,
		})
	end,
	cond = function()
		-- Don't start when opening a file
		if vim.fn.argc() > 0 then
			return false
		end

		-- Don't start if the current buffer has any lines
		local lines = vim.api.nvim_buf_get_lines(0, 0, 2, true)
		if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then
			return false
		end

		-- Don't start if there are several listed buffers
		for _, buf_id in pairs(vim.api.nvim_list_bufs()) do
			local bufinfo = vim.fn.getbufinfo(buf_id)
			if bufinfo.listed == 1 and #bufinfo.windows > 0 then
				return false
			end
		end

		-- Don't start if the current buffer is explicitly modifiable
		if not vim.o.modifiable then
			return false
		end

		for _, arg in pairs(vim.v.argv) do
			-- Alpha should be present when measuring startup time
			if arg == '--startuptime' then
				return true
			end

			-- Don't start when classic script arguments are present
			if arg == '-b' or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then
				return false
			end
		end

		return true
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

return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	opts = function()
		local function pad(config)
			local height = vim.api.nvim_win_get_height(0)
			local center = math.ceil(height / 2)
			local dbc = math.ceil((#config.center + #config.center - 1 + #config.header + #config.footer) / 2)
			for _ = 1, center - dbc do
				table.insert(config.header, 1, '')
			end
			return config
		end
		local ascii = {
			[[  ,-.       _,---._ __  /\   ]],
			[[ /  )    .-'       `./ /   \ ]],
			[[(  (   ,'            `/    /|]],
			[[ \  `-"             \'\   / |]],
			[[  `.              ,  \ \ /  |]],
			[[   /`.          ,'-`----Y   |]],
			[[  (            ;        |   ']],
			[[  |  ,-.    ,-'         |  / ]],
			[[  |  | (   |            | /  ]],
			[[  )  |  \  `.___________|/   ]],
			[[  `--'   `--'                ]],
			[[                             ]],
			[[                             ]],
		}
		local opts = {
			theme = 'doom',
			hide = { statusline = false },
			shortcut_type = 'letter',
			config = pad({
				header = ascii,
				center = {
					{
						action = 'Telescope session-lens search_session',
						desc = ' Show Sessions',
						icon = ' ',
						key = 's',
					},
					{
						action = 'enew',
						desc = ' New file',
						icon = ' ',
						key = 'e',
					},
					{
						action = 'Telescope find_files',
						desc = ' Find files',
						icon = ' ',
						key = 'f',
					},
					{
						action = 'Telescope oldfiles',
						desc = ' Recent files',
						icon = ' ',
						key = 'r',
					},
					{
						action = 'Lazy',
						desc = ' Lazy',
						icon = ' ',
						key = 'l',
					},
					{
						action = 'Mason',
						desc = ' Mason',
						icon = ' ',
						key = 'm',
					},
					{
						action = 'qa',
						desc = ' Quit',
						icon = ' ',
						key = 'q',
					},
				},
				footer = {},
			}),
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
			button.key_format = '  %s'
		end

		return opts
	end,
}

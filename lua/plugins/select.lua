-- TODO: Dressing is archived!
-- https://github.com/stevearc/dressing.nvim/issues/190
return {
	'stevearc/dressing.nvim',
	init = function()
		vim.ui.select = function(...)
			require('lazy').load { plugins = { 'dressing.nvim' } }
			return vim.ui.select(...)
		end
		vim.ui.input = function(...)
			require('lazy').load { plugins = { 'dressing.nvim' } }
			return vim.ui.input(...)
		end
	end,
	opts = {
		input = {
			enabled = true,
			default_prompt = 'Input',
			trim_prompt = true,
			title_pos = 'left',
			insert_only = true,
			start_in_insert = true,
			border = 'rounded',
			relative = 'cursor',
			win_options = {
				wrap = false,
				list = true,
				listchars = 'precedes:…,extends:…',
				sidescrolloff = 0,
			},
			mappings = {
				n = {
					['<Esc>'] = 'Close',
					['<CR>'] = 'Confirm',
				},
				i = {
					['<C-c>'] = 'Close',
					['<CR>'] = 'Confirm',
					['<Up>'] = 'HistoryPrev',
					['<Down>'] = 'HistoryNext',
				},
			},
		},
		select = {
			enabled = true,
			backend = 'nui',
			trim_prompt = true,
			nui = {
				position = {
					row = 2,
					col = 0,
				},
				size = false,
				relative = 'cursor',
				border = { style = 'rounded' },
				buf_options = {
					swapfile = false,
					filetype = 'DressingSelect',
				},
				win_options = { winblend = 0 },
				max_width = 80,
				max_height = 20,
				min_width = 1,
				min_height = 1,
			},
			get_config = function(opts)
				if opts.kind == 'mason.ui.language-filter' then
					return {
						backend = 'telescope',
					}
				end
			end,
		},
	},
	dependencies = { 'nvim-telescope/telescope.nvim', 'MunifTanjim/nui.nvim' },
}

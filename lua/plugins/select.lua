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
			backend = { 'telescope' },
			trim_prompt = true,
			telescope = {
				theme = 'cursor',
				layout_strategy = 'cursor',
				layout_config = {
					width = function(_, max_columns, _)
						return math.min(max_columns, 40)
					end,
					height = function(_, _, max_lines)
						return math.min(max_lines, 6)
					end,
				},
			},
		},
	},
	dependencies = { 'nvim-telescope/telescope.nvim' },
}

return {
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		opts = function()
			return {
				defaults = {
					theme = 'dropdown',
					initial_mode = 'insert',
					mappings = {
						i = {
							['<esc>'] = require('telescope.actions').close,
						},
					},
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--trim',
					},
					pickers = {
						find_files = {
							hidden = true,
							no_ignore = true,
							follow = true,
						},
					},
					results_title = false,
					sorting_strategy = 'ascending',
					layout_strategy = 'center',
					layout_config = {
						preview_cutoff = 1,
						width = function(_, max_columns, _)
							return math.min(max_columns, 100)
						end,
						height = function(_, _, max_lines)
							return math.min(max_lines, 25)
						end,
					},
					border = true,
					borderchars = {
						prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
						results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
						preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
					},
				},
			}
		end,
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'LukasPietzschmann/telescope-sessions',
		dev = true,
		config = function()
			require('telescope').load_extension 'telescope-sessions'
		end,
		dependencies = { 'sessions.nvim', 'nvim-telescope/telescope.nvim' },
	},
	{
		'LukasPietzschmann/telescope-tabs',
		dev = true,
		config = function()
			require('telescope').load_extension 'telescope-tabs'
			require('telescope-tabs').setup {
				entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
					local entry_string = table.concat(
						vim.tbl_map(function(v)
							return v:gsub(vim.fn.getcwd() .. '/', './')
						end, file_paths),
						', '
					)
					return string.format('%d: %s%s', tab_id, entry_string, is_current and ' <' or '')
				end,
			}
		end,
		dependencies = { 'nvim-telescope/telescope.nvim' },
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		init = function()
			require('telescope').load_extension 'ui-select'
		end,
		dependencies = { 'nvim-telescope/telescope.nvim' },
	},
}

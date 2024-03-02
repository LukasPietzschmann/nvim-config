return {
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		keys = function()
			local function is_git_repo()
				vim.fn.system 'git rev-parse --is-inside-work-tree'
				return vim.v.shell_error == 0
			end

			local function get_git_root_of_cwd()
				if not is_git_repo() then
					return vim.fn.getcwd()
				end
				local dot_git_path = vim.fn.finddir('.git', '.;')
				return vim.fn.fnamemodify(dot_git_path, ':h')
			end

			local function cwd_opts()
				return { cwd = get_git_root_of_cwd() }
			end

			return {
				{ '<C-p>', function() require('telescope.builtin').find_files(cwd_opts()) end },
				{ '<C-S-p>', function() require('telescope.builtin').find_files({
					table.unpack(cwd_opts()),
					attach_mappings = function(_, map)
						map('i', '<CR>', 'select_tab_drop')
						return true
					end,
				}) end },
				{ '<C-f>', function() require('telescope.builtin').live_grep(cwd_opts()) end },
				{ '<C-S-f>', function() require('telescope.builtin').live_grep({
					table.unpack(cwd_opts()),
					attach_mappings = function(_, map)
						map('i', '<CR>', 'select_tab_drop')
						return true
					end,
				}) end },
				{ '<C-k>', function() require('telescope.builtin').lsp_document_symbols() end },
				{ '<C-S-k>', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end },
			}
		end,
		opts = function()
			local config = require 'telescope.config'
			local actions = lazy_require 'telescope.actions'
			local vimgrep_arguments = { table.unpack(config.values.vimgrep_arguments) }
			table.insert(vimgrep_arguments, '--hidden')
			table.insert(vimgrep_arguments, '--follow')
			table.insert(vimgrep_arguments, '--smart-case')
			return {
				defaults = {
					theme = 'dropdown',
					initial_mode = 'insert',
					mappings = {
						i = {
							['<esc>'] = function(...)
								actions.close(...)
							end,
						},
					},
					vimgrep_arguments = vimgrep_arguments,
					file_ignore_patterns = {'node_modules', '.git'},
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
				pickers = {
					find_files = {
						hidden = true,
						follow = true,
						no_ignore = true,
						no_ignore_parent = true,
						mappings = {
							i = { ['<CR>'] = 'select_drop' }
						},
					},
					live_grep = {
						mappings = {
							i = { ['<CR>'] = 'select_drop' }
						},
					},
					lsp_dynamic_workspace_symbols = {
						mappings = {
							i = { ['<CR>'] = 'select_drop' }
						},
					},
				},
			}
		end,
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		config = function()
			require('telescope').load_extension 'fzf'
		end,
	},
	{
		'LukasPietzschmann/telescope-tabs',
		keys = {
			{ '<A-k>', function() require('telescope-tabs').list_tabs() end },
			{ '<C-s>b', function() require('telescope-tabs').go_to_previous() end },
		},
		dev = true,
		config = function()
			require('telescope').load_extension 'telescope-tabs'
			require('telescope-tabs').setup {
				entry_formatter = function(tab_id, _, _, file_paths, is_current)
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
}

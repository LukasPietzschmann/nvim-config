return {
	'nvim-neo-tree/neo-tree.nvim',
	cmd = 'Neotree',
	opts = {
		auto_clean_after_session_restore = true,
		close_floats_on_escape_key = true,
		close_if_last_window = true,
		enable_git_status = true,
		enable_diagnostics = true,
		enable_modified_markers = true,
		enable_opened_markers = true,
		enable_refresh_on_write = true,
		use_default_mappings = false,
		popup_border_style = 'NC',
		sources = {
			'filesystem',
			'document_symbols',
		},
		source_selector = {
			winbar = true,
			sources = {
				{ source = 'filesystem' },
				{ source = 'document_symbols' },
			},
		},
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = false,
			},
			icon = {
				folder_closed = '',
				folder_open = '',
				folder_empty = 'ﰊ',
			},
			modified = {
				symbol = '[+]',
				highlight = 'NeoTreeModified',
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = false,
				highlight = 'NeoTreeFileName',
			},
			git_status = {
				symbols = {
					added = '✚',
					modified = '',
					deleted = '✖',
					renamed = '',
					untracked = '',
					ignored = '',
					unstaged = '',
					staged = '',
					conflict = '',
				},
			},
		},
		window = {
			position = 'left',
			width = 40,
			mappings = {
				['<cr>'] = 'open',
				['<space>'] = { 'toggle_preview', config = { use_float = true } },
				['<esc>'] = 'revert_preview',
				['<tab>'] = function(state)
					local node = state.tree:get_node()
					if require('neo-tree.utils').is_expandable(node) then
						state.commands['toggle_node'](state)
					else
						state.commands['open'](state)
						vim.cmd 'Neotree reveal'
					end
				end,
				['S'] = 'open_split',
				['s'] = 'open_vsplit',
				['t'] = 'open_tabnew',
				['d'] = 'delete',
				['r'] = 'rename',
				['m'] = 'move',
				['R'] = 'refresh',
				['?'] = 'show_help',
				['<'] = 'prev_source',
				['>'] = 'next_source',
			},
		},
		filesystem = {
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = true,
			},
			follow_current_file = true,
			group_empty_dirs = true,
			hijack_netrw_behavior = 'open_default',
			use_libuv_file_watcher = true,
			window = {
				mappings = {
					['/'] = 'fuzzy_finder',
				},
				fuzzy_finder_mappings = {
					['<down>'] = 'move_cursor_down',
					['<up>'] = 'move_cursor_up',
				},
			},
		},
	},
	config = function(_, opts)
		vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

		vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
		vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
		vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
		vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

		require('neo-tree').setup(opts)
	end,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
}

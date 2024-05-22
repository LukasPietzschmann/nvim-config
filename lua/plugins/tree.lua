return {
	'nvim-neo-tree/neo-tree.nvim',
	cmd = 'Neotree',
	keys = { { '<C-S-o>', '<cmd>Neotree toggle<CR>' } },
	opts = {
		close_if_last_window = true,
		enable_git_status = false,
		enable_diagnostics = true,
		enable_modified_markers = true,
		enable_opened_markers = true,
		enable_refresh_on_write = true,
		use_default_mappings = false,
		popup_border_style = 'rounded',
		sources = { 'filesystem' },
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
				folder_closed = icons.folder.closed,
				folder_open = icons.folder.open,
				folder_empty = icons.folder.empty,
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
		},
		window = {
			position = 'left',
			width = 40,
			mappings = {
				['<cr>'] = 'open_drop',
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
				['t'] = 'open_tab_drop',
				['d'] = 'delete',
				['r'] = 'rename',
				['m'] = 'move',
				['n'] = 'add',
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
			follow_current_file = {
				enabled = true,
			},
			group_empty_dirs = true,
			hijack_netrw_behavior = 'disabled',
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
		vim.g.neo_tree_remove_legacy_commands = 1

		vim.fn.sign_define('DiagnosticSignError', { text = icons.diagnostics.error, texthl = 'DiagnosticSignError' })
		vim.fn.sign_define('DiagnosticSignWarn', { text = icons.diagnostics.warning, texthl = 'DiagnosticSignWarn' })
		vim.fn.sign_define('DiagnosticSignInfo', { text = icons.diagnostics.info, texthl = 'DiagnosticSignInfo' })
		vim.fn.sign_define('DiagnosticSignHint', { text = icons.diagnostics.hint, texthl = 'DiagnosticSignHint' })

		require('neo-tree').setup(opts)

		vim.api.nvim_create_autocmd('VimLeavePre', {
			desc = 'Closes the file tree before NeoVim exits',
			group = CloseStuffBeforeExitGroup,
			callback = function()
				vim.cmd 'tabdo Neotree close'
			end,
		})
	end,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
}

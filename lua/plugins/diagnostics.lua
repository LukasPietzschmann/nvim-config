return {
	'folke/trouble.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = { { '<C-d>', function() require('trouble').toggle() end, } },
	opts = {
		position = 'bottom',
		height = 10,
		icons = true,
		mode = 'document_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
		severity = nil, -- all
		fold_open = '',
		fold_closed = '',
		group = true,
		padding = false,
		cycle_results = false,
		action_keys = {
			close = 'q',
			cancel = '<esc>',
			refresh = 'r',
			jump = { '<cr>', '<leftmouse>' },
			open_split = { 's' },
			open_vsplit = { '<v>' },
			open_tab = { 't' },
			jump_close = {},
			toggle_mode = 'm',
			switch_severity = {},
			toggle_preview = {},
			hover = '<space>',
			preview = {},
			open_code_href = {},
			close_folds = {},
			open_folds = {},
			toggle_fold = {},
			previous = {},
			next = {},
			help = '?',
		},
		multiline = true,
		indent_lines = true,
		win_config = { border = 'rounded' },
		auto_open = false,
		auto_close = true,
		auto_preview = false,
		auto_fold = false,
		auto_jump = { '' },
		include_declaration = { 'lsp_references', 'lsp_implementations', 'lsp_definitions' }, -- for the given modes, include the declaration of the current symbol in the results
		use_diagnostic_signs = true,
	},
	config = function(_, opts)
		require('trouble').setup(opts)
		vim.api.nvim_create_autocmd('VimLeavePre' , {
			desc = 'Closes trouble before NeoVim exits',
			group = CloseStuffBeforeExitGroup,
			callback = function()
				if not IsPluginLoaded 'trouble.nvim' then
					return
				end
				require('trouble').close()
			end,
		})
	end,
}

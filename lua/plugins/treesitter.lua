local required_tools = LazyRequire 'required-tools'

return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = { 'BufReadPre', 'BufAdd' },
		cmd = 'TSUpdate',
		build = ':TSUpdate',
		opts = {
			textobjects = {
				select = {
					enable = true,
					lookahead = false,
					keymaps = {
						['if'] = '@function.inner',
						['af'] = '@function.outer',
						['ip'] = '@parameter.inner',
						['ap'] = '@parameter.outer',
						['as'] = '@statement.outer',
					},
				},
				--[[ swap = {
					enable = true,
					swap_next = {
						['sp'] = '@parameter.inner',
					},
				}, ]]
				--[[ lsp_interop = {
					enable = true,
					border = 'none',
					peek_definition_code = {
						['sf'] = '@function.outer',
						['sc'] = '@class.outer',
					},
				}, ]]
			},
			ensure_installed = required_tools.parsers,
			sync_install = false,
			highlight = { enable = true },
		},
		main = 'nvim-treesitter.configs',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	},
}

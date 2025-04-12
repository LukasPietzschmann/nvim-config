local required_tools = lazy_require 'required-tools'

return {
	'nvim-treesitter/nvim-treesitter',
	lazy = vim.fn.argc(-1) == 0,
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
					['ia'] = '@attribute.outer',
					['aa'] = '@attribute.outer',
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
}

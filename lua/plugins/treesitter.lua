local required_tools = lazy_require 'required-tools'

return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		lazy = vim.fn.argc(-1) == 0,
		event = { 'BufReadPre', 'BufAdd' },
		cmd = 'TSUpdate',
		build = ':TSUpdate',
		opts = {
			ensure_installed = required_tools.parsers,
			highlight = { enable = true },
		},
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		branch = 'main',
		lazy = vim.fn.argc(-1) == 0,
		keys = {
			{ 'ip', mode = {'x', 'o'}, desc = 'Inner Parameter', function()
				require 'nvim-treesitter-textobjects.select'.select_textobject('@parameter.inner', 'textobjects')
			end},
			{ 'ap', mode = {'x', 'o'}, desc = 'Outer Parameter', function()
				require 'nvim-treesitter-textobjects.select'.select_textobject('@parameter.outer', 'textobjects')
			end},
			{ 'ia', mode = {'x', 'o'}, desc = 'Inner Attribute', function()
				require 'nvim-treesitter-textobjects.select'.select_textobject('@attribute.inner', 'textobjects')
			end},
			{ 'aa', mode = {'x', 'o'}, desc = 'Outer Attribute', function()
				require 'nvim-treesitter-textobjects.select'.select_textobject('@attribute.outer', 'textobjects')
			end},
		},
		opts = {
			select = {
				lookahead = false,
			},
		},
	},
}

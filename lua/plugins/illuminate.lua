return {
	'RRethy/vim-illuminate',
	event = { 'BufReadPre', 'BufAdd' },
	config = function(_, opts)
		require('illuminate').configure(opts)
	end,
	opts = {
		providers = { 'lsp', 'treesitter' },
	},
}

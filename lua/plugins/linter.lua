return {
	'mfussenegger/nvim-lint',
	ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'c', 'cpp', 'cmake' },
	opts = {
		typescript = { 'eslint_d' },
		typescriptreact = { 'eslint_d' },
		javascript = { 'eslint_d' },
		javascriptreact = { 'eslint_d' },
		c = { 'clangtidy' },
		cpp = { 'clangtidy' },
	},
	config = function(_, opts)
		require('lint').linters_by_ft = opts
	end,
}

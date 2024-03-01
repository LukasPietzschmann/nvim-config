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
		local linter = require 'lint'
		linter.linters_by_ft = opts
		vim.api.nvim_create_autocmd('BufWritePost', {
			desc = 'Runs the linter on save',
			group = vim.api.nvim_create_augroup('RunLinter', { clear = true }),
			callback = function()
				linter.try_lint()
			end,
		})
	end,
}

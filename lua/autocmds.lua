vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
	callback = function()
		require('neo-tree.sources.manager').close_all()
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
	callback = function()
		vim.highlight.on_yank {
			hgroup = 'IncSearch',
			timeout = 200,
		}
	end,
})

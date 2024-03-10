vim.api.nvim_create_autocmd('VimLeavePre', {
	desc = 'Closes all floating windows before NeoVim exits',
	group = CloseStuffBeforeExitGroup,
	callback = function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(win).relative ~= '' then
				vim.api.nvim_win_close(win, false)
			end
		end
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlights the yanked text',
	group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
	callback = function()
		vim.highlight.on_yank {
			hgroup = 'IncSearch',
			timeout = 200,
		}
	end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'VeryLazy',
	desc = 'Set "spell" later, as it takes a while',
	group = vim.api.nvim_create_augroup('SetSpell', { clear = true }),
	callback = function()
		vim.opt_global.spell = true
		vim.opt.spelllang = { 'en', 'de' }
		return true
	end,
})

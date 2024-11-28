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

local marks = lazy_require 'marks'
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	group = vim.api.nvim_create_augroup('Marks', { clear = true }),
	callback = function(args)
		marks.BufWinEnterHandler(args)
	end,
})

local make_on_set = { 'n', 'N', '*', '#', '?', '/' }
local keep_on_set = vim.list_extend({ '<C-E>', '<C-Y>', '<ScrollWheelUp>', '<ScrollWheelDown>' }, make_on_set)
vim.on_key(function(char)
	if vim.fn.mode() == 'n' then
		local key = vim.fn.keytrans(char)
		local make_on = vim.tbl_contains(make_on_set, key)
		local keep_on = vim.tbl_contains(keep_on_set, key)
		local new_value = make_on or (vim.opt.hlsearch:get() and keep_on)
		vim.opt.hlsearch = new_value
	end
end, vim.api.nvim_create_namespace 'auto_hlsearch')

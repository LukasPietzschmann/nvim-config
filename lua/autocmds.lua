vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
	callback = function()
		require('neo-tree.sources.manager').close_all()
		require('trouble').close()
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

vim.api.nvim_create_autocmd('BufWritePost', {
	callback = function()
		if IsPluginLoaded 'nvim-lint' then
			require('lint').try_lint()
		end
	end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'MasonToolsStartingInstall',
	callback = function()
		vim.schedule(function()
			print '[Mason] Installing tools ...'
		end)
	end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'MasonToolsUpdateCompleted',
	callback = function(e)
		vim.schedule(function()
			print('[Mason] Installed: ' .. vim.inspect(e.data))
		end)
	end,
})

local ignore_filetypes = { 'neo-tree' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup', 'help', 'quickfix' }

local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
			vim.b.focus_disable = true
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
			vim.b.focus_disable = true
		end
	end,
})

local unlinkgrp = vim.api.nvim_create_augroup('UnlinkSnippetOnModeChange', { clear = true })
vim.api.nvim_create_autocmd('ModeChanged', {
	group = unlinkgrp,
	pattern = { 's:n', 'i:*' },
	callback = function(evt)
		local luasnip = require 'luasnip'
		if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
			luasnip.unlink_current()
		end
	end,
})

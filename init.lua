vim.api.nvim_cmd({
	cmd = 'colorscheme',
	args = { 'gruvluke' },
	bang = false,
}, {})

-- For nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
	defaults = {
		lazy = true,
	},
	dev = {
		path = '/home/luke/src',
		fallback = false,
	},
	install = {
		colorscheme = { 'gruvluke' },
	},
	change_detection = {
		enabled = false,
	},
	ui = {
		border = 'rounded',
	},
})

function Is_plugin_loaded(name)
	return require('lazy.core.config').plugins[name]._.loaded ~= nil
end

require 'options'
require 'keymap'
-- require 'tmux'
require 'autocmds'

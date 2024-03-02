vim.loader.enable()

function LazyRequire(require_path)
	return setmetatable({}, {
		__index = function(_, key)
			return require(require_path)[key]
		end,
		__newindex = function(_, key, value)
			require(require_path)[key] = value
		end,
		__call = function(_, ...)
			return require(require_path)(...)
		end,
	})
end

vim.api.nvim_cmd({
	cmd = 'colorscheme',
	args = { 'gruvluke' },
	bang = false,
}, {})

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
	checker = {
		enabled = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				'netrwPlugin',
				'rplugin',
				'gzip',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
})

function IsPluginLoaded(name)
	return require('lazy.core.config').plugins[name]._.loaded ~= nil
end

CloseStuffBeforeExitGroup = vim.api.nvim_create_augroup('CloseStuffBeforeExit', { clear = true })

require 'options'
require 'keymap'
-- require 'tmux'
require 'autocmds'

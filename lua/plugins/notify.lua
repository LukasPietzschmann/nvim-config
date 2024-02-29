return {
	'rcarriga/nvim-notify',
	keys = {
		{
			'<C-x>',
			function()
				require('notify').dismiss { silent = true, pending = false }
			end,
		},
	},
	init = function()
		vim.notify = function(...)
			require 'notify'(...)
		end
	end,
	opts = {
		fps = 60,
		level = vim.log.levels.DEBUG,
		stages = 'slide',
		timeout = 7000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		on_open = function(win)
			vim.api.nvim_win_set_config(win, { zindex = 100 })
		end,
	},
}

require 'plugins.statusline.helpers'

return {
	'rebelot/heirline.nvim',
	event = 'VeryLazy',
	init = function()
		-- disable initially, so we don't get any flicker
		vim.opt.laststatus = 0
	end,
	opts = function()
		local conditions = lazy_require 'heirline.conditions'

		local Mode = require('plugins.statusline.mode').Mode
		local AttachedTools = require('plugins.statusline.attached_tools').AttachedTools
		local Copilot = require('plugins.statusline.copilot').Copilot
		local Diagnostics = require('plugins.statusline.diagnostics').Diagnostics

		local Ruler = surround({ '', icons.powerline.right_rounded }, 'bg1', nil, 'bg0', { provider = '%l:%c %P' })

		local SelectionCount = {
			condition = function(self)
				local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
				self.mode = mode
				return mode == 'v' or mode == '\22' or mode == 'V'
			end,
			{
				provider = function(self)
					local line_start, col_start = vim.fn.line 'v', vim.fn.col 'v'
					local line_end, col_end = vim.fn.line '.', vim.fn.col '.'
					if self.mode == '\22' then
						return string.format(
							'%dx%d',
							math.abs(line_start - line_end) + 1,
							math.abs(col_start - col_end) + 1
						)
					elseif self.mode == 'V' or line_start ~= line_end then
						return math.abs(line_start - line_end) + 1
					elseif self.mode == 'v' then
						return math.abs(col_start - col_end) + 1
					end
				end,
			},
			Space(2),
		}

		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
			end,
			flexible = 40,
			{
				Space(2),
				{
					provider = function(self)
						return ' ' .. truncate(self.status_dict.head, 10)
					end,
				},
			},
			Empty,
		}

		local SearchCount = {
			condition = function(self)
				if vim.v.hlsearch ~= 1 then
					return false
				end

				local search = vim.fn.searchcount { maxcount = 99999 }
				if search.total ~= nil and search.total > 0 then
					self.search = search
					return true
				end
				return false
			end,
			provider = function(self)
				return string.format('[%d/%d]', self.search.current, self.search.total)
			end,
			Space(2),
		}

		local MainLine = {
			hl = 'Normal',
			Space,
			{
				hl = { fg = 'fg4', bg = 'bg1' },
				Mode,
				Git,
				Fill,
				Copilot,
				Diagnostics,
				AttachedTools,
				SearchCount,
				SelectionCount,
				Ruler,
			},
			Space,
		}

		return {
			statusline = MainLine,
			opts = { colors = require('gruvluke.palette').get_base_colors() },
		}
	end,
	config = function(_, opts)
		require('heirline').setup(opts)
		vim.opt.laststatus = 3
	end,
}

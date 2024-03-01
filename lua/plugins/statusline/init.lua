return {
	'rebelot/heirline.nvim',
	event = 'VeryLazy',
	init = function()
		-- disable initially, so we don't get any flicker
		vim.api.nvim_set_option_value('laststatus', 0, {})
	end,
	opts = function()
		local conditions = require 'heirline.conditions'
		local helpers = require 'plugins.statusline.helpers'

		local Mode = require('plugins.statusline.mode').Mode
		local AttachedTools = require('plugins.statusline.attached_tools').AttachedTools
		local Copilot = require('plugins.statusline.copilot').Copilot
		local Diagnostics = require('plugins.statusline.diagnostics').Diagnostics
		local Space = helpers.Space
		local Fill = helpers.Fill
		local Empty = helpers.Empty

		local icons = helpers.icons
		local surround = helpers.surround
		local trunc = helpers.truncate

		local Ruler = surround({ '', icons.powerline.right_rounded }, 'bg1', nil, 'bg0', { provider = '%l:%c %P' })

		local Navic = {
			condition = function()
				return IsPluginLoaded 'nvim-navic' and require('nvim-navic').is_available()
			end,
			update = 'CursorMoved',
			Space(2),
			{
				provider = function()
					return require('nvim-navic').get_location()
				end,
			},
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
						return ' ' .. trunc(self.status_dict.head, 10)
					end,
				},
			},
			Empty,
		}

		local SearchCount = {
			condition = function(self)
				local search = vim.fn.searchcount { maxcount = 99999 }
				if search.total > 0 then
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
				Navic,
				Fill,
				Copilot,
				Diagnostics,
				AttachedTools,
				SearchCount,
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
		vim.api.nvim_set_option_value('laststatus', 3, {})
	end,
}

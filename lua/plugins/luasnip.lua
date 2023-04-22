return {
	'L3MON4D3/LuaSnip',
	opts = function()
		local types = require 'luasnip.util.types'

		return {
			history = true,
			updateevents = 'TextChanged,TextChangedI',
			region_check_events = 'CursorMoved,CursorHold,InsertEnter',
			delete_check_events = 'TextChanged,InsertLeave',
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { '●', 'GruvboxOrange' } },
					},
				},
				[types.insertNode] = {
					active = {
						virt_text = { { '●', 'GruvboxBlue' } },
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require('luasnip').config.setup(opts)
		require('luasnip.loaders.from_vscode').lazy_load {
			paths = { './snippets' },
		}
	end,
}

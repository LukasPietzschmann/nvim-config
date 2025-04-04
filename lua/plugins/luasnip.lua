return {
	'L3MON4D3/LuaSnip',
	build = 'make install_jsregexp',
	version = '*',
	opts = function()
		local types = require 'luasnip.util.types'

		return {
			updateevents = 'TextChanged,TextChangedI',
			region_check_events = 'CursorMoved,CursorHold,InsertEnter',
			delete_check_events = 'TextChanged,InsertLeave',
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { '●', 'GruvlukeOrange' } },
					},
				},
				[types.insertNode] = {
					active = {
						virt_text = { { '●', 'GruvlukeBlue' } },
					},
				},
			},
		}
	end,
	config = function(_, opts)
		local luasnip = require 'luasnip'
		luasnip.config.setup(opts)
		require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets' } }
	end,
}

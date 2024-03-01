return {
	'L3MON4D3/LuaSnip',
	build = 'make install_jsregexp',
	opts = function()
		local types = require 'luasnip.util.types'

		return {
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
		local luasnip = require 'luasnip'
		luasnip.config.setup(opts)
		require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets' } }
		vim.api.nvim_create_autocmd('ModeChanged', {
			pattern = { 's:n', 'i:*' },
			desc = 'Exits "snippet mode" when switching to normal mode',
			group = vim.api.nvim_create_augroup('LuaSnipUnlinkSnippetOnModeChange', { clear = true }),
			callback = function(e)
				if not luasnip.session or not luasnip.session.current_nodes[e.buf] or luasnip.session.jump_active then
					return
				end
				luasnip.unlink_current()
			end,
		})
	end,
}

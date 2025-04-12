return {
	'saghen/blink.cmp',
	version = '*',
	event = { 'InsertEnter', 'CmdlineEnter' },
	opts = function()
		local suggestions = lazy_require 'copilot.suggestion'
		local lspkind = lazy_require 'lspkind'
		local webicons = lazy_require 'nvim-web-devicons'

		return {
			completion = {
				accept = {
					dot_repeat = false,
					create_undo_point = true,
					auto_brackets = { enabled = true },
				},
				menu = {
					auto_show = false,
					border = 'rounded',
					direction_priority = { 'n', 's' },
					draw = {
						columns = {
							{ 'label', 'label_description', width = { fill = true } },
							{ 'kind_icon', 'kind', gap = 1 },
							{ 'source_name' },
						},
						treesitter = { 'lsp' },
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local icon = ctx.kind_icon

									if vim.tbl_contains({ 'Path' }, ctx.source_name) then
										local dev_icon, _ = webicons.get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = lspkind.symbolic(ctx.kind, { mode = 'symbol' })
									end

									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ 'Path' }, ctx.source_name) then
										local dev_icon, dev_hl = webicons.get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
				keyword = { range = 'prefix' },
				trigger = {
					prefetch_on_insert = true,
					show_on_keyword = false,
					show_on_trigger_character = false,
				},
				ghost_text = { enabled = true, show_without_menu = false },
				list = { selection = { preselect = true, auto_insert = false } },
				documentation = {
					auto_show = true,
					window = {
						border = 'rounded',
						direction_priority = {
							menu_north = { 'e', 'n', 'w', 's' },
							menu_south = { 'e', 's', 'w', 'n' },
						},
					},
				},
			},

			keymap = {
				preset = 'none',
				['<C-Space>'] = { 'show' },
				['<esc>'] = { 'cancel', 'fallback' },
				['<CR>'] = { 'accept', 'fallback' },
				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<Tab>'] = {
					function(cmp)
						return cmp.is_visible()
					end,
					'snippet_forward',
					function()
						if suggestions.is_visible() then
							suggestions.accept()
							return true
						end
						return false
					end,
					'fallback',
				},
				['<S-Tab>'] = {
					function(cmp)
						return cmp.is_visible()
					end,
					'snippet_backward',
					'fallback',
				},
			},

			cmdline = {
				keymap = {
					preset = 'none',
					['<C-Space>'] = { 'show', 'fallback' },
					['<esc>'] = { 'cancel', 'fallback' },
					['<CR>'] = { 'select_and_accept', 'fallback' },
					['<Up>'] = { 'select_prev', 'fallback' },
					['<Down>'] = { 'select_next', 'fallback' },
					['<Tab>'] = { 'show_and_insert', 'select_next', 'fallback' },
					['<S-Tab>'] = { 'select_prev', 'fallback' },
				},
			},

			sources = {
				default = { 'snippets', 'lsp', 'path', 'buffer' },
				providers = {
					lsp = { name = '[lsp]' },
					path = { name = '[path]' },
					buffer = { name = '[buf]' },
					snippets = { name = '[snp]' },
				},
			},

			snippets = { preset = 'luasnip' },

			signature = {
				enabled = true,
				trigger = { enabled = false },
				window = {
					border = 'rounded',
					scrollbar = true,
				},
			},

			fuzzy = {
				implementation = 'prefer_rust',
				sorts = {
					'exact',
					'score',
					'sort_text',
				},
			},
		}
	end,
	opts_extend = { 'sources.default' },
	dependencies = {
		'nvim-tree/nvim-web-devicons',
		'onsails/lspkind.nvim',
		'windwp/nvim-autopairs',
		{ 'L3MON4D3/LuaSnip', version = '*' },
	},
}

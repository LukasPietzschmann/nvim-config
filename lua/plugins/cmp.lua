return {
	'hrsh7th/nvim-cmp',
	keys = {
		{ '<C-Space>', mode = 'i' },
		{ '<Tab>', mode = 'c' },
	},
	event = 'InsertEnter',
	opts = function()
		local cmp = require 'cmp'
		local luasnip = lazy_require 'luasnip'
		local lspkind = require 'lspkind'

		return {
			enabled = function()
				if vim.api.nvim_get_mode().mode == 'c' then --command-line editing
					return true
				end

				local context = require 'cmp.config.context'
				return not context.in_treesitter_capture 'comment' and not context.in_syntax_group 'Comment'
			end,
			performance = { fetching_timeout = 5000 },
			preselect = cmp.PreselectMode.Item,
			completion = { autocomplete = false },
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			matching = {
				disallow_fuzzy_matching = false,
				disallow_fullfuzzy_matching = false,
				disallow_partial_fuzzy_matching = false,
				disallow_partial_matching = true,
				disallow_prefix_unmatching = false,
			},
			mapping = cmp.mapping.preset.insert {
				['<C-Space>'] = cmp.mapping.complete(),
				['<esc>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
				['<Tab>'] = cmp.mapping(function(fallback)
					local suggestions = lazy_require 'copilot.suggestion'
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif suggestions.is_visible() then
						suggestions.accept()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = cmp.config.sources({
				{ name = 'luasnip', option = { use_show_condition = false } },
				{ name = 'nvim_lsp' },
				{ name = 'path' },
			}, {
				{ name = 'treesitter' },
			}, {
				{ name = 'buffer' },
			}),
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					function(entry1, entry2)
						local _, entry1_under = entry1.completion_item.label:find '^_+'
						local _, entry2_under = entry2.completion_item.label:find '^_+'
						entry1_under = entry1_under or 0
						entry2_under = entry2_under or 0
						if entry1_under > entry2_under then
							return false
						elseif entry1_under < entry2_under then
							return true
						end
					end,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			formatting = {
				format = lspkind.cmp_format {
					before = function(_, vim_item)
						vim_item.abbr = string.sub(vim_item.abbr, 1, 35)
						return vim_item
					end,
					mode = 'symbol_text',
					menu = {
						buffer = '[buf]',
						nvim_lsp = '[lsp]',
						treesitter = '[ts]',
						luasnip = '[snp]',
						path = '[path]',
					},
				},
			},
		}
	end,
	config = function(_, opts)
		local cmp = require 'cmp'
		local cmp_autopairs = lazy_require 'nvim-autopairs.completion.cmp'
		local cmdline_format = {
			format = function(_, vim_item)
				vim_item.kind = nil
				return vim_item
			end,
		}

		cmp.setup(opts)
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources {
				{ name = 'buffer' },
			},
			formatting = cmdline_format,
		})
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline {
				['<Tab>'] = {
					c = function()
						if cmp.visible() then
							cmp.select_next_item()
						else
							cmp.complete()
							cmp.select_next_item { count = 0 } -- select first item
						end
					end,
				},
			},
			sources = cmp.config.sources {
				{ name = 'path' },
				{ name = 'cmdline' },
			},
			formatting = cmdline_format,
		})

		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		-- Disabled because of https://github.com/hrsh7th/nvim-cmp/issues/1187
		--[[ cmp.event:on('menu_opened', function()
			vim.b.copilot_suggestion_hidden = true
		end)

		cmp.event:on('menu_closed', function()
			vim.b.copilot_suggestion_hidden = false
		end) ]]
	end,
	dependencies = {
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-cmdline',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'ray-x/cmp-treesitter',
		'onsails/lspkind.nvim',
		'L3MON4D3/LuaSnip',
		'windwp/nvim-autopairs',
		'zbirenbaum/copilot.lua',
	},
}

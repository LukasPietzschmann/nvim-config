return {
	'hrsh7th/nvim-cmp',
	keys = { '<C-Space>', mode = 'i' },
	event = 'InsertEnter',
	opts = function()
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
		local lspkind = require 'lspkind'
		return {
			enabled = function()
				local context = require 'cmp.config.context'
				if vim.api.nvim_get_mode().mode == 'c' then
					return true
				else
					return not context.in_treesitter_capture 'comment' and not context.in_syntax_group 'Comment'
				end
			end,
			preselect = cmp.PreselectMode.Item,
			completion = {
				autocomplete = false,
			},
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
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_partial_matching = true,
				disallow_prefix_unmatching = false,
			},
			mapping = cmp.mapping.preset.insert {
				['<C-Space>'] = cmp.mapping.complete(),
				['<esc>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
				['<Tab>'] = cmp.mapping(function(fallback)
					local suggestions = require 'copilot.suggestion'
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
			experimental = {
				ghost_text = true,
			},
		}
	end,
	config = function(_, opts)
		local cmp = require 'cmp'
		local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

		cmp.setup(opts)

		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		cmp.event:on('menu_opened', function()
			vim.b.copilot_suggestion_hidden = true
		end)

		cmp.event:on('menu_closed', function()
			vim.b.copilot_suggestion_hidden = false
		end)
	end,
	dependencies = {
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-buffer',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'ray-x/cmp-treesitter',
		'onsails/lspkind.nvim',
		'L3MON4D3/LuaSnip',
		'windwp/nvim-autopairs',
		'zbirenbaum/copilot.lua',
	},
}

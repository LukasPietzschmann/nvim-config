local function on_attach(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		require('nvim-navic').attach(client, bufnr)
	end
end

local required_tools = lazy_require 'required-tools'

return {
	-- Order should be:
	-- 	1: mason
	-- 	2: mason-lspconfig
	-- 	3: lspconfig
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufAdd' },
		init = function()
			local bufopts = { noremap = true, silent = true }
			vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename, bufopts)
			vim.keymap.set('n', '<M-CR>', vim.lsp.buf.code_action, bufopts)
			vim.keymap.set('n', 'ht', '<cmd>ClangdSwitchSourceHeader<CR>')
			vim.keymap.set('n', '<A-i>', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = nil })
			end)
			-- vim.keymap.set('n', '<C-a>', vim.lsp.buf.hover, bufopts) -- See fold.lua
			vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = 'rounded',
				focusable = false,
			})
			vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = 'rounded',
				focusable = false,
			})
			vim.lsp.inlay_hint.enable(false, {
				bufnr = nil,
			})
		end,
		config = function()
			local capabilities =
				require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local lspconfig = require 'lspconfig'
			lspconfig.clangd.setup {
				capabilities = { table.unpack(capabilities), offsetEncoding = 'utf-8' },
				on_attach = on_attach,
				cmd = {
					'clangd',
					'--background-index',
					'--completion-style=detailed',
					'--function-arg-placeholders',
					'--header-insertion=never',
					'--pch-storage=memory',
					'--limit-references=100',
					'--limit-results=20',
					'-j=16',
				},
				settings = {
					clangd = {
						InlayHints = {
							Designators = true,
							Enabled = true,
							ParameterNames = true,
							DeducedTypes = true,
						},
					},
				},
			}
			lspconfig.texlab.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					texlab = {
						auxDirectory = './aux',
						chktex = {
							onEdit = false,
							onOpenAndSave = true,
						},
					},
				},
			}
			lspconfig.lua_ls.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT',
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								vim.env.VIMRUNTIME .. '/lua',
								table.unpack(vim.api.nvim_list_runtime_paths()),
							},
						},
						telemetry = { enable = false },
						diagnostics = {
							disable = { 'lowercase-global' },
						},
						hint = { enable = true },
					},
				},
			}
			lspconfig.ts_ls.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					completions = {
						completeFunctionCalls = true,
					},
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = 'all',
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = 'all',
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			}
			lspconfig.hls.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.marksman.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.cmake.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.vimls.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.r_language_server.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.zls.setup { capabilities = capabilities, on_attach = on_attach }
		end,
		dependencies = {
			'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
			'SmiteshP/nvim-navic',
			'hrsh7th/cmp-nvim-lsp',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'SmiteshP/nvim-navic',
			'mrded/nvim-lsp-notify',
		},
	},
	{
		'williamboman/mason.nvim',
		cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
		opts = {
			ui = {
				border = 'rounded',
				height = 0.8,
			},
		},
		build = function(_)
			require('mason-tool-installer').check_install(true)
		end,
	},
	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		cmd = { 'MasonToolsInstall', 'MasonToolsUpdate' },
		init = function()
			local group = vim.api.nvim_create_augroup('MasonNotifications', { clear = true })
			vim.api.nvim_create_autocmd('User', {
				pattern = 'MasonToolsStartingInstall',
				desc = 'Notifies the user when a tool is being installed',
				group = group,
				callback = function()
					vim.schedule(function()
						vim.notify('Installing tools', vim.log.levels.INFO, { title = 'Mason' })
					end)
				end,
			})
			vim.api.nvim_create_autocmd('User', {
				pattern = 'MasonToolsUpdateCompleted',
				desc = 'Notifies the user when a tool has been installed',
				group = group,
				callback = function(e)
					vim.schedule(function()
						vim.notify('Installed ' .. vim.inspect(e.data), vim.log.levels.INFO, { title = 'Mason' })
					end)
				end,
			})
		end,
		opts = {
			ensure_installed = {
				table.unpack(required_tools.lsps),
				table.unpack(required_tools.formatter),
				table.unpack(required_tools.linter),
			},
			run_on_start = false,
		},
	},
	{
		'SmiteshP/nvim-navic',
		opts = {
			depth_limit = 4,
			depth_limit_indicator = '..',
			click = true,
			icons = {
				File = '',
				Module = '',
				Namespace = '',
				Package = '',
				Class = '',
				Method = '',
				Property = '',
				Field = '',
				Constructor = '',
				Enum = '',
				Interface = '',
				Function = '',
				Variable = '',
				Constant = '',
				String = '',
				Number = '',
				Boolean = '',
				Array = '',
				Object = '',
				Key = '',
				Null = '',
				EnumMember = '',
				Struct = '',
				Event = '',
				Operator = '',
				TypeParameter = '',
			},
		},
	},
	{
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require('lsp_lines').setup()
			vim.diagnostic.config {
				virtual_text = false,
			}
		end,
	},
	{
		'dnlhc/glance.nvim',
		keys = {
			{ 'gr', '<CMD>Glance references<CR>' },
			{ 'gd', '<CMD>Glance definitions<CR>' },
			{ 'gi', '<CMD>Glance implementations<CR>' },
			{ 'gt', '<CMD>Glance type_definitions<CR>' },
		},
		config = function()
			local glance = require 'glance'
			local actions = glance.actions
			glance.setup {
				height = 22,
				detached = function(winid)
					return vim.api.nvim_win_get_width(winid) < 100
				end,
				preview_win_opts = {
					cursorline = true,
					number = true,
					wrap = true,
				},
				list = {
					position = 'right',
					width = 0.33,
				},
				border = { enable = false },
				theme = {
					enable = true,
					mode = 'auto',
					multiplier = 2,
				},
				mappings = {
					list = {
						['<Down>'] = actions.next,
						['<Up>'] = actions.previous,
						['<Tab>'] = actions.next_location,
						['<S-Tab>'] = actions.previous_location,
						['v'] = actions.jump_vsplit,
						['s'] = actions.jump_split,
						['t'] = actions.jump_tab,
						['<CR>'] = actions.jump,
						['<space>'] = actions.enter_win 'preview',
						['q'] = actions.close,
						['Q'] = actions.close,
						['<esc>'] = actions.close,
					},
					preview = {
						['q'] = actions.close,
						['Q'] = actions.close,
						['<esc>'] = actions.close,
						['<Tab>'] = actions.next_location,
						['<S-Tab>'] = actions.previous_location,
						['<space>'] = actions.enter_win 'list',
					},
				},
				hooks = {
					before_open = function(results, open, jump, _)
						local uri = vim.uri_from_bufnr(0)
						if #results == 1 then
							local target_uri = results[1].uri or results[1].targetUri
							if target_uri == uri then
								jump(results[1])
							else
								open(results)
							end
						else
							open(results)
						end
					end,
				},
				folds = {
					fold_closed = icons.arrow.right,
					fold_open = icons.arrow.down,
					folded = true,
				},
				indent_lines = {
					enable = true,
					icon = ' ',
				},
				winbar = { enable = true },
			}
		end,
	},
	{
		'mrded/nvim-lsp-notify',
		dependencies = { 'rcarriga/nvim-notify' },
	},
}

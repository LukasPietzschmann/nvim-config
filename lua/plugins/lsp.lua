local required_tools = lazy_require 'required-tools'

return {
	-- Order:
	-- mason
	-- mason-lspcofig
	-- lspconfig
	{
		'neovim/nvim-lspconfig',
		keys = {
			{ '<C-r>', vim.lsp.buf.rename },
			{ '<M-CR>', vim.lsp.buf.code_action },
			{ 'ht', '<cmd>ClangdSwitchSourceHeader<CR>' },
			{
				'<A-i>',
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = nil })
				end,
			},
		},
		cmd = { 'LspInfo', 'LspStart', 'LspStop', 'LspRestart' },
		init = function()
			local lspConfigPath = require('lazy.core.config').options.root .. '/nvim-lspconfig'
			vim.opt.runtimepath:prepend(lspConfigPath) -- prepend to prioritize local configs under /lsp

			-- Taken from https://github.com/Saghen/blink.cmp/blob/main/lua/blink/cmp/sources/lib/init.lua#L278
			local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), {
				textDocument = {
					completion = {
						completionItem = {
							snippetSupport = true,
							commitCharactersSupport = false,
							documentationFormat = { 'markdown', 'plaintext' },
							deprecatedSupport = true,
							preselectSupport = false,
							tagSupport = { valueSet = { 1 } },
							insertReplaceSupport = true,
							resolveSupport = {
								properties = {
									'documentation',
									'detail',
									'additionalTextEdits',
									'command',
									'data',
								},
							},
							insertTextModeSupport = {
								valueSet = { 1 },
							},
							labelDetailsSupport = true,
						},
						completionList = {
							itemDefaults = {
								'commitCharacters',
								'editRange',
								'insertTextFormat',
								'insertTextMode',
								'data',
							},
						},
						contextSupport = true,
						insertTextMode = 1,
					},
				},
			})
			vim.lsp.config('*', { capabilities = capabilities })
			vim.lsp.inlay_hint.enable(false, { bufnr = nil })
			vim.diagnostic.config {
				underline = false,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.warning,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.info,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
					},
				},
				virtual_text = false,
				virtual_lines = true,
			}
		end,
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
		'williamboman/mason-lspconfig.nvim',
		-- lazy = false,
		event = 'VeryLazy',
		config = function()
			require('mason-lspconfig').setup()
			require('mason-lspconfig').setup_handlers {
				function(name)
					vim.lsp.enable(name)
				end,
			}
		end,
		dependencies = { 'williamboman/mason.nvim' },
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
}

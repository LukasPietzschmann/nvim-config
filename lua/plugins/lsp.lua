local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	if client.server_capabilities.documentSymbolProvider then
		require('nvim-navic').attach(client, bufnr)
	end
	vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<M-CR>', vim.lsp.buf.code_action, bufopts)
end

local required_tools = require 'required-tools'

return {
	-- Order should be:
	-- 	1: mason
	-- 	2: mason-lspconfig
	-- 	3: lspconfig
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufAdd' },
		config = function()
			local lspconfig = require 'lspconfig'

			lspconfig.clangd.setup {
				capabilities = capabilities,
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
			}
			-- Don't use Mason for hls
			lspconfig.texlab.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					texlab = {
						auxDirectory = './aux',
						build = {
							args = {},
							executable = 'make',
							forwardSearchAfter = false,
							onSave = false,
						},
						chktex = {
							onEdit = false,
							onOpenAndSave = false,
						},
						diagnosticsDelay = 300,
						formatterLineLength = 120,
					},
				},
			}
			lspconfig.lua_ls.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						telemetry = { enable = false },
						diagnostics = { globals = { 'vim' } },
					},
				},
			}
			lspconfig.tsserver.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.marksman.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.cmake.setup { capabilities = capabilities, on_attach = on_attach }
			lspconfig.vimls.setup { capabilities = capabilities, on_attach = on_attach }

			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'java',
				callback = function()
					require('jdtls').start_or_attach {
						capabilities = capabilities,
						on_attach = on_attach,
						cmd = {
							'java',
							'-javaagent:/home/luke/.local/share/nvim/mason/packages/jdtls/lombok.jar',
							'-Declipse.application=org.eclipse.jdt.ls.core.id1',
							'-Dosgi.bundles.defaultStartLevel=4',
							'-Declipse.product=org.eclipse.jdt.ls.core.product',
							'-Dlog.protocol=true',
							'-Dlog.level=ALL',
							'-Xmx10G',
							'-Xms5G',
							'--add-modules=ALL-SYSTEM',
							'--add-opens',
							'java.base/java.util=ALL-UNNAMED',
							'--add-opens',
							'java.base/java.lang=ALL-UNNAMED',
							'-jar',
							'/home/luke/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
							'-configuration',
							'/home/luke/.local/share/nvim/mason/packages/jdtls/config_linux',
							'-data',
							'/home/luke/.cache/jdtls/workspace',
						},
						root_dir = require('jdtls.setup').find_root { '.git', 'settings.gradle', 'build.gradle' },
					}
				end,
			})
		end,
		dependencies = {
			'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
			'SmiteshP/nvim-navic',
			'hrsh7th/cmp-nvim-lsp',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'mfussenegger/nvim-jdtls',
			'SmiteshP/nvim-navic',
		},
	},
	{
		'williamboman/mason.nvim',
		cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
		opts = {
			ui = { border = 'rounded' },
		},
		build = function(_)
			require('mason-tool-installer').check_install(true)
		end,
		dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
	},
	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		cmd = { 'MasonToolsInstall', 'MasonToolsUpdate' },
		opts = {
			ensure_installed = {
				unpack(required_tools.lsps),
				unpack(required_tools.formatter),
				unpack(required_tools.linter),
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
}

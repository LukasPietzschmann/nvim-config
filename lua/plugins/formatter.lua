return {
	'stevearc/conform.nvim',
	event = 'VeryLazy',
	cmd = 'ConformInfo',
	keys = { {
		'<A-f>',
		function()
			require('conform').format()
		end,
	} },
	opts = {
		formatters_by_ft = {
			cpp = { 'clang-format' },
			c = { 'clang-format' },
			java = { 'google-java-format' },
			lua = { 'stylua' },
			python = { 'black' },
			tex = { 'latexindent' },
			plaintex = { 'latexindent' },
			javascript = { 'eslint_d' },
			javascriptreact = { 'eslint_d' },
			typescript = { 'eslint_d' },
			typescriptreact = { 'eslint_d' },
			css = { 'prettier' },
			html = { 'prettier' },
			json = { 'prettier' },
			yaml = { 'prettier' },
			svelte = { 'prettier' },
			r = { 'styler' },
			zig = { 'zigfmt' },
			go = { 'gofmt' },
			haskell = { 'stylish-haskell' },
			markdown = { 'mdformat' },
			['_'] = { 'trim_whitespace' },
		},
		default_format_opts = {
			async = true,
			lsp_format = 'fallback',
		},
		notify_no_formatters = true,
	},
}

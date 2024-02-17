return {
	'mhartington/formatter.nvim',
	cmd = { 'Format', 'FormatWrite' },
	keys = { { '<A-f>', '<cmd>Format<CR>' } },
	opts = function()
		local any_ft = require 'formatter.filetypes.any'
		return {
			filetype = {
				cpp = { require('formatter.filetypes.cpp').clangformat },
				c = { require('formatter.filetypes.c').clangformat },
				java = { require('formatter.filetypes.java').clangformat },
				lua = { require('formatter.filetypes.lua').stylua },
				python = { require('formatter.filetypes.python').black },
				tex = { require('formatter.filetypes.latex').latexindent },
				plaintex = { require('formatter.filetypes.latex').latexindent },
				-- javascript = { prettier },
				-- javascriptreact = { prettier },
				-- typescript = { prettier },
				-- typescriptreact = { prettier },
				javascript = { require('formatter.filetypes.javascript').eslint_d },
				javascriptreact = { require('formatter.filetypes.javascriptreact').eslint_d },
				typescript = { require('formatter.filetypes.typescript').eslint_d },
				typescriptreact = { require('formatter.filetypes.typescriptreact').eslint_d },
				css = { require('formatter.filetypes.css').prettier },
				html = { require('formatter.filetypes.html').prettier },
				json = { require('formatter.filetypes.json').prettier },
				yaml = { require('formatter.filetypes.yaml').prettier },
				['*'] = { any_ft.remove_trailing_whitespace },
			},
		}
	end,
}

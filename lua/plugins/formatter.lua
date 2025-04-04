local util = lazy_require 'formatter.util'

return {
	'mhartington/formatter.nvim',
	cmd = { 'Format', 'FormatWrite' },
	keys = { { '<A-f>', '<cmd>Format<CR>' } },
	opts = function()
		local any_ft = lazy_require 'formatter.filetypes.any'
		return {
			filetype = {
				cpp = { require('formatter.filetypes.cpp').clangformat },
				c = { require('formatter.filetypes.c').clangformat },
				java = {
					{
						exe = 'google-java-format',
						args = {
							'--skip-javadoc-formatting',
							util.escape_path(util.get_current_buffer_file_path()),
							'--replace',
						},
						stdin = true,
					},
				},
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
				svelte = { require('formatter.filetypes.svelte').prettier },
				r = { require('formatter.filetypes.r').styler },
				zig = { require('formatter.filetypes.zig').zigfmt },
				go = { require('formatter.filetypes.go').gofmt },
				-- TODO: change formatter in hls settings
				haskell = { require('formatter.filetypes.haskell').stylish_haskell },
				--[[ haskell = {
					{
						exe = 'fourmolu',
						args = {
							'--stdin-input-file',
							util.escape_path(util.get_current_buffer_file_name()),
						},
						stdin = true,
					},
				}, ]]
				markdown = { require('formatter.filetypes.markdown').prettier },
				['*'] = {
					function(...)
						any_ft.remove_trailing_whitespace(...)
					end,
				},
			},
		}
	end,
}

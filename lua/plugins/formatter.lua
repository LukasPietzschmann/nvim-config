local prettier = function(parser)
	if not parser then
		return {
			exe = 'prettier',
			args = {
				'--stdin-filepath',
				require('formatter.util').escape_path(require('formatter.util').get_current_buffer_file_path()),
			},
			stdin = true,
			try_node_modules = true,
		}
	end

	return {
		exe = 'prettier',
		args = {
			'--stdin-filepath',
			require('formatter.util').escape_path(require('formatter.util').get_current_buffer_file_path()),
			'--parser',
			parser,
		},
		stdin = true,
		try_node_modules = true,
	}
end

local clangformat = function()
	return {
		exe = 'clang-format',
		args = {
			'-assume-filename',
			require('formatter.util').escape_path(require('formatter.util').get_current_buffer_file_name()),
		},
		stdin = true,
		try_node_modules = true,
	}
end

return {
	'mhartington/formatter.nvim',
	cmd = { 'Format', 'FormatWrite' },
	keys = { { '<A-f>', '<cmd>Format<CR>' } },
	opts = function()
		local util = require 'formatter.util'
		local any_ft = require 'formatter.filetypes.any'
		return {
			filetype = {
				cpp = { clangformat },
				c = { clangformat },
				java = { clangformat },
				lua = {
					function()
						return {
							exe = 'stylua',
							args = {
								'--search-parent-directories',
								'--stdin-filepath',
								util.escape_path(util.get_current_buffer_file_path()),
								'--',
								'-',
							},
							stdin = true,
						}
					end,
				},
				python = {
					require('formatter.filetypes.python').black,
				},
				tex = {
					require('formatter.filetypes.latex').latexindent,
				},
				javascript = { prettier },
				javascriptreact = { prettier },
				typescript = { prettier },
				typescriptreact = { prettier },
				css = { prettier },
				html = { prettier },
				json = { prettier },
				yaml = { prettier },
				['*'] = { any_ft.remove_trailing_whitespace },
			},
		}
	end,
}

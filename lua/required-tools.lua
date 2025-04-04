local M = {}

M.lsps = {
	'clangd',
	'cmake',
	'gopls',
	'gradle_ls',
	'hls',
	'jdtls',
	'lua_ls',
	'marksman',
	'pyright',
	'r_language_server',
	'texlab',
	'ts_ls',
	'vimls',
	'zls',
}

M.formatter = {
	'black',
	'clang-format',
	'fourmolu',
	'google_java_format',
	'latexindent',
	'prettier',
	'stylua',
}

M.linter = {
	'cmakelint',
	'eslint_d',
}

M.parsers = {
	'c',
	'cpp',
	'css',
	'cmake',
	'make',
	'comment',
	'llvm',
	'vim',
	'vimdoc',
	'vimdoc',
	'lua',
	'query',
	'kdl',
	'javascript',
	'typescript',
	'java',
	'haskell',
	'latex',
	'kotlin',
	'bibtex',
	'python',
	'markdown',
	'markdown_inline',
	'gitcommit',
	'gitignore',
	'regex',
	'r',
	'go',
	'svelte',
	'zig',
}

return M

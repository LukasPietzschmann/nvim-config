local M = {}

M.lsps = {
	'clangd',
	'texlab',
	'lua_ls',
	'tsserver',
	'pyright',
	'marksman',
	'cmake',
	'vimls',
	'jdtls',
}

M.formatter = {
	'black',
	'clang-format',
	'latexindent',
	'prettier',
	'stylua',
}

M.linter = {
	'eslint_d',
}

M.parsers = {
	'c',
	'cpp',
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
	'java',
	'haskell',
	'latex',
	'bibtex',
	'python',
	'markdown',
	'gitcommit',
	'gitignore',
	'regex',
	'r',
}

return M

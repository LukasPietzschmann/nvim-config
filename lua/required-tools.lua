local M = {}

M.lsps = {
	'clangd',
	'cmake',
	'hls',
	'lua_ls',
	'marksman',
	'pyright',
	'texlab',
	'tsserver',
	'vimls',
}

M.formatter = {
	'black',
	'clang-format',
	'fourmolu',
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
	'bibtex',
	'python',
	'markdown',
	'gitcommit',
	'gitignore',
	'regex',
	'r',
	'svelte',
}

return M

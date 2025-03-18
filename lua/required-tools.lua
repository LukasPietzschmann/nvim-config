local M = {}

M.lsps = {
	'clangd',
	'cmake',
	'gopls',
	'hls',
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

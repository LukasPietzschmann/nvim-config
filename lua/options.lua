local api = vim.api

function WinbarContent()
	local alignment = '%='
	local filename = '%f'
	local modifiers = '[%M%R%H%W] '
	local expanded_filename = api.nvim_eval_statusline(filename, { use_winbar = true })
	local expanded_modifiers = api.nvim_eval_statusline(modifiers, { use_winbar = true })
	if expanded_modifiers.width <= 3 then
		return alignment .. expanded_filename.str
	end
	return alignment .. expanded_modifiers.str .. expanded_filename.str
end

vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- use tabstop
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.autoread = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.belloff = { 'cursor', 'esc' }
vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.cmdheight = 0
vim.opt.ignorecase = true
vim.opt.wildmode = { 'longest', 'list', 'lastused' }
vim.opt.wrap = false
vim.opt.smoothscroll = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.list = true
vim.opt.listchars = { tab = '> ', trail = '-', nbsp = '+', lead = '·' }
vim.opt.signcolumn = 'auto'
vim.opt.foldcolumn = 'auto'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
vim.opt.winbar = '%{%v:lua.WinbarContent()%}'
vim.opt.fixendofline = false
vim.opt.hlsearch = false
vim.opt.guicursor = 'a:block'
vim.opt.undofile = true
vim.opt.textwidth = 88
vim.opt.splitkeep = 'screen'
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.scrolloff = 4
vim.opt.formatoptions = 'croqlj'
vim.opt.history = 10000
vim.opt.title = true
vim.opt.titlestring = '%t'
vim.opt.shortmess = 'mrwaoOsTF'

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.netrw_liststyle = 3 -- tree style
vim.g.netrw_use_errorwindow = 1 -- popup for errors

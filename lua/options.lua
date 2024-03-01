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

api.nvim_set_option_value('termguicolors', true, {})
api.nvim_set_option_value('syntax', 'on', {})
api.nvim_set_option_value('tabstop', 4, {})
api.nvim_set_option_value('shiftwidth', 0, {}) -- use tabstop
api.nvim_set_option_value('autoindent', true, {})
api.nvim_set_option_value('smartindent', true, {})
api.nvim_set_option_value('autoread', true, {})
api.nvim_set_option_value('backspace', 'indent,eol,start', {})
api.nvim_set_option_value('belloff', 'cursor,esc', {})
api.nvim_set_option_value('breakindent', true, {})
api.nvim_set_option_value('confirm', true, {})
api.nvim_set_option_value('cmdheight', 0, {})
api.nvim_set_option_value('ignorecase', true, {})
api.nvim_set_option_value('wildmode', 'longest,list,lastused', {})
api.nvim_set_option_value('wrap', false, {})
api.nvim_set_option_value('title', true, {})
api.nvim_set_option_value('cursorline', true, {})
api.nvim_set_option_value('cursorlineopt', 'number', {})
api.nvim_set_option_value('number', true, {})
api.nvim_set_option_value('mouse', 'a', {})
api.nvim_set_option_value('mousemodel', 'extend', {})
api.nvim_set_option_value('spell', true, {})
api.nvim_set_option_value('spelllang', 'en,de', {})
api.nvim_set_option_value('list', true, {})
api.nvim_set_option_value('listchars', 'tab:> ,trail:-,nbsp:+,lead:·', {})
api.nvim_set_option_value('signcolumn', 'auto', {})
api.nvim_set_option_value('foldcolumn', 'auto', {})
api.nvim_set_option_value('foldmethod', 'expr', {})
api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', {})
api.nvim_set_option_value('foldenable', false, {})
api.nvim_set_option_value('winbar', '%{%v:lua.WinbarContent()%}', {})
api.nvim_set_option_value('fixendofline', false, {})
api.nvim_set_option_value('hlsearch', false, {})
api.nvim_set_option_value('guicursor', 'a:block', {})
api.nvim_set_option_value('undofile', true, {})
api.nvim_set_option_value('textwidth', 88, {})
api.nvim_set_option_value('splitkeep', 'screen', {})
api.nvim_set_option_value('lazyredraw', true, {})
api.nvim_set_option_value('linebreak', true, {})
api.nvim_set_option_value('scrolloff', 0, {})
api.nvim_set_option_value('formatoptions', 'croqlj', {})
api.nvim_set_option_value('history', '10000', {})

vim.cmd 'set title titlestring=%t'

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0


vim.fn.sign_define('LightBulbSign', { texthl = '' })

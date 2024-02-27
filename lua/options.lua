vim.filetype.add {
	extension = {
		ky = 'kyra',
	},
}

function WinbarContent()
	local alignment = '%='
	local filename = '%f'
	local modifiers = '[%M%R%H%W] '
	local expanded_filename = vim.api.nvim_eval_statusline(filename, { use_winbar = true })
	local expanded_modifiers = vim.api.nvim_eval_statusline(modifiers, { use_winbar = true })
	if expanded_modifiers.width <= 3 then
		return alignment .. expanded_filename.str
	end
	return alignment .. expanded_modifiers.str .. expanded_filename.str
end

vim.api.nvim_set_option_value('termguicolors', true, {})
vim.api.nvim_set_option_value('syntax', 'on', {})
vim.api.nvim_set_option_value('tabstop', 4, {})
vim.api.nvim_set_option_value('shiftwidth', 0, {}) -- use tabstop
vim.api.nvim_set_option_value('autoindent', true, {})
vim.api.nvim_set_option_value('smartindent', true, {})
vim.api.nvim_set_option_value('autoread', true, {})
vim.api.nvim_set_option_value('backspace', 'indent,eol,start', {})
vim.api.nvim_set_option_value('belloff', 'cursor,esc', {})
vim.api.nvim_set_option_value('breakindent', true, {})
vim.api.nvim_set_option_value('confirm', true, {})
vim.api.nvim_set_option_value('cmdheight', 0, {})
vim.api.nvim_set_option_value('ignorecase', true, {})
vim.api.nvim_set_option_value('wildmode', 'longest,list,lastused', {})
vim.api.nvim_set_option_value('wrap', false, {})
vim.api.nvim_set_option_value('title', true, {})
vim.api.nvim_set_option_value('cursorline', true, {})
vim.api.nvim_set_option_value('cursorlineopt', 'number', {})
vim.api.nvim_set_option_value('number', true, {})
vim.api.nvim_set_option_value('mouse', 'a', {})
vim.api.nvim_set_option_value('mousemodel', 'extend', {})
vim.api.nvim_set_option_value('spell', true, {})
vim.api.nvim_set_option_value('spelllang', 'en,de', {})
vim.api.nvim_set_option_value('list', true, {})
vim.api.nvim_set_option_value('listchars', 'tab:> ,trail:-,nbsp:+,lead:·', {})
vim.api.nvim_set_option_value('signcolumn', 'auto', {})
vim.api.nvim_set_option_value('foldcolumn', 'auto', {})
vim.api.nvim_set_option_value('foldmethod', 'expr', {})
vim.api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', {})
vim.api.nvim_set_option_value('foldenable', false, {})
vim.api.nvim_set_option_value('winbar', '%{%v:lua.WinbarContent()%}', {})
vim.api.nvim_set_option_value('fixendofline', false, {})
vim.api.nvim_set_option_value('hlsearch', false, {})
vim.api.nvim_set_option_value('guicursor', 'a:block', {})
vim.api.nvim_set_option_value('undofile', true, {})
vim.api.nvim_set_option_value('textwidth', 88, {})
vim.api.nvim_set_option_value('splitkeep', 'screen', {})
vim.api.nvim_set_option_value('lazyredraw', true, {})
vim.api.nvim_set_option_value('linebreak', true, {})
vim.api.nvim_set_option_value('scrolloff', 0, {})
vim.api.nvim_set_option_value('formatoptions', 'croqlj', {})
vim.api.nvim_set_option_value('history', '10000', {})

vim.cmd 'set title titlestring=%t'

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0


vim.fn.sign_define('LightBulbSign', { texthl = '' })

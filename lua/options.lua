vim.filetype.add {
	extension = {
		ky = 'kyra',
	},
}

vim.api.nvim_set_option_value('termguicolors', true, {})
vim.api.nvim_set_option_value('syntax', 'on', {})
vim.api.nvim_set_option_value('background', 'dark', {})
vim.api.nvim_set_option_value('completeopt', 'menu,menuone,noselect', {})
vim.api.nvim_set_option_value('tabstop', 4, {})
vim.api.nvim_set_option_value('shiftwidth', 4, {})
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
vim.api.nvim_set_option_value('foldmethod', 'manual', {})
vim.api.nvim_set_option_value('winbar', '%=%r%m %f', {})
vim.api.nvim_set_option_value('laststatus', 3, {})
vim.api.nvim_set_option_value('fixendofline', false, {})
vim.api.nvim_set_option_value('hlsearch', false, {})
vim.api.nvim_set_option_value('guicursor', 'a:block', {})
vim.api.nvim_set_option_value('undofile', true, {})
vim.api.nvim_set_option_value('textwidth', 88, {})
-- vim.api.nvim_set_option_value('showcmdloc', 'statusline', {})
vim.api.nvim_set_option_value('splitkeep', 'screen', {})
vim.api.nvim_set_option_value(
	'sessionoptions',
	'blank,buffers,curdir,folds,help,tabpages,winsize,terminal,resize,winpos',
	{}
)

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bold = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bold = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bold = true })

-- vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'black' })

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

vim.fn.sign_define('LightBulbSign', { texthl = '' })

vim.keymap.set('n', '<A-f>', ':Format<CR>')

vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<C-f>', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<A-o>', '<cmd>Telescope telescope-sessions search_sessions<CR>')

vim.keymap.set('n', '<C-k>', '<cmd>Telescope lsp_document_symbols<CR>')
vim.keymap.set('n', '<C-S-k>', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>')
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
vim.keymap.set('n', '<C-d>', '<cmd>Telescope diagnostics<CR>')

vim.keymap.set('n', 'ht', '<cmd>ClangdSwitchSourceHeader<CR>')

vim.keymap.set('n', '<C-w>w', '<cmd>:vsp<CR><C-w><Right>')
vim.keymap.set('n', '<C-w>c', '<cmd>:q<CR>')

-- https://erwin.co/getting-ctrltab-to-work-in-neovim/
vim.keymap.set('n', '<C-Tab>', '<cmd>:tabn<CR>')
vim.keymap.set('n', '<C-S-Tab>', '<cmd>:tabp<CR>')

vim.keymap.set('n', '<C-s><Right>', '<cmd>:tabn<CR>')
vim.keymap.set('n', '<C-s><Left>', '<cmd>:tabp<CR>')
vim.keymap.set('n', '<C-s>s', '<cmd>:tabe<CR>')
vim.keymap.set('n', '<C-s>c', '<cmd>:tabc<CR>')
vim.keymap.set('n', '<A-k>', '<cmd>Telescope telescope-tabs list_tabs<CR>')
vim.keymap.set('n', '<C-s>b', function()
	require('telescope-tabs').go_to_previous()
end)

vim.keymap.set('n', 'gm', 'm')
vim.keymap.set('n', 'm', 'd')
vim.keymap.set('x', 'm', 'd')
vim.keymap.set('n', 'mm', 'dd')
vim.keymap.set('n', 'M', 'D')

vim.keymap.set('n', 'z', '<cmd>:redo<CR>')

vim.keymap.set('n', '<', '<<')
vim.keymap.set('n', '>', '>>')

vim.keymap.set('n', '<C-S-o>', function()
	--[[ local is_neotree_focused = function()
		-- Get our current buffer number
		local bufnr = vim.api.nvim_get_current_buf and vim.api.nvim_get_current_buf() or vim.fn.bufnr()
		-- Get all the available sources in neo-tree
		for _, source in ipairs(require('neo-tree').config.sources) do
			-- Get each sources state
			local state = require('neo-tree.sources.manager').get_state(source)
			-- Check if the source has a state, if the state has a buffer and if the buffer is our current buffer
			if state and state.bufnr and state.bufnr == bufnr then
				return true
			end
		end
		return false
	end
	if is_neotree_focused() then
		vim.cmd ':Neotree toggle'
	else
		vim.cmd ':Neotree focus'
	end ]]
	vim.cmd ':Neotree toggle'
end, {})

vim.keymap.set('n', '<C-d>h', function()
	require('duck').hatch()
end, {})
vim.keymap.set('n', '<C-d>c', function()
	require('duck').cook()
end, {})

vim.api.nvim_cmd({
	cmd = 'cnoreabbrev',
	args = { 'W', 'w' },
	bang = false,
}, {})

vim.api.nvim_cmd({
	cmd = 'cnoreabbrev',
	args = { 'Wa', 'wa' },
	bang = false,
}, {})

vim.api.nvim_cmd({
	cmd = 'cnoreabbrev',
	args = { 'Wqa', 'wqa' },
	bang = false,
}, {})

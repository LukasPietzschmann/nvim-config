vim.keymap.set('n', '<C-w>w', '<cmd>:vsp<CR><C-w><Right>')
vim.keymap.set('n', '<C-w>c', '<cmd>:q<CR>')
vim.keymap.set('n', '<C-w>e', '<C-w>=')

-- https://erwin.co/getting-ctrltab-to-work-in-neovim/
vim.keymap.set('n', '<C-Tab>', '<cmd>:tabn<CR>')
vim.keymap.set('n', '<C-S-Tab>', '<cmd>:tabp<CR>')

vim.keymap.set('n', '<C-s><Right>', '<cmd>:tabn<CR>')
vim.keymap.set('n', '<C-s><Left>', '<cmd>:tabp<CR>')
vim.keymap.set('n', '<C-s>s', '<cmd>:tabe<CR>')
vim.keymap.set('n', '<C-s>c', '<cmd>:tabc<CR>')

-- vim.keymap.set('n', 'gm', 'm')
vim.keymap.set('n', 'm', 'd')
vim.keymap.set('x', 'm', 'd')
vim.keymap.set('n', 'mm', 'dd')
vim.keymap.set('n', 'M', 'D')

vim.keymap.set('n', 'U', '<cmd>:redo<CR>')

vim.keymap.set('n', '<', '<<')
vim.keymap.set('n', '>', '>>')

-- Should ideally be part of vim-cutlass
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('x', 'p', '"_dP')

-- In and decrement
-- incrementing numbers
vim.api.nvim_set_keymap('n', '<C-D>', '<C-A>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-D>', '<C-A>', { noremap = true, silent = true })
-- decrementing numbers
vim.api.nvim_set_keymap('n', '<C-S>', '<C-X>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S>', '<C-X>', { noremap = true, silent = true })

-- Quickfix
vim.keymap.set('n', '<A-n>', '<cmd>:cnext<CR>')
vim.keymap.set('n', '<A-p>', '<cmd>:cprev<CR>')
vim.keymap.set('n', '<A-o>', function()
	if vim.tbl_isempty(vim.fn.getqflist()) then
		vim.notify('Quickfix list is empty', 'warn')
		return
	end

	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win['quickfix'] == 1 then
			qf_exists = true
		end
	end

	if qf_exists then
		vim.cmd 'cclose'
	else
		vim.cmd 'copen'
	end
end)

local function alias(from, to)
	vim.api.nvim_create_user_command(from, function(_)
		vim.cmd(to)
	end, {})
end
alias('W', 'w')
alias('Wa', 'wa')
alias('Wq', 'wq')
alias('Wqa', 'wqa')
alias('Qa', 'qa')


-- vim.cmd [[
-- fun! SetupCommandAlias(from, to)
-- 	exec 'cnoreabbrev <expr> '.a:from
-- 		\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
-- 		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
-- endfun
-- call SetupCommandAlias("w","update")
-- call SetupCommandAlias("W","w")
-- call SetupCommandAlias("Wa","wa")
-- call SetupCommandAlias("Wqa","wqa")
-- call SetupCommandAlias("Qa","qa")
-- ]]

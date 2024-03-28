vim.keymap.set('n', 'ht', '<cmd>ClangdSwitchSourceHeader<CR>')

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

vim.keymap.set('n', 'gm', 'm')
vim.keymap.set('n', 'm', 'd')
vim.keymap.set('x', 'm', 'd')
vim.keymap.set('n', 'mm', 'dd')
vim.keymap.set('n', 'M', 'D')

vim.keymap.set('n', 'U', '<cmd>:redo<CR>')

vim.keymap.set('n', '<', '<<')
vim.keymap.set('n', '>', '>>')

vim.keymap.set('x', 'p', '"_dP')

vim.cmd [[
fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
		\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("w","update")
call SetupCommandAlias("W","w")
call SetupCommandAlias("Wa","wa")
call SetupCommandAlias("Wqa","wqa")
call SetupCommandAlias("Qa","qa")
]]

local virt_text = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = ('󰁂 %d '):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local hlGroup = chunk[2]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, { chunkText, 'Folded' })
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	local ralign = math.max(math.min(vim.opt.textwidth:get(), width - 1) - curWidth - sufWidth, 0)
	local padding = ' ' .. ('·'):rep(ralign - 2) .. ' '
	table.insert(newVirtText, { padding, 'Folded' })
	table.insert(newVirtText, { suffix, 'Folded' })
	return newVirtText
end

return {
	'LukasPietzschmann/nvim-ufo',
	event = 'VeryLazy',
	opts = {
		close_fold_kinds_for_ft = { default = { 'imports', 'comment' } },
		fold_virt_text_handler = virt_text,
		provider_selector = function(_, _, _)
			return { 'lsp', 'treesitter', 'indent' }
		end,
		preview = { win_config = { winblend = 0 } },
	},
	init = function()
		vim.opt.fillchars = { fold = ' ', foldopen = '', foldsep = ' ', foldclose = '' }
		vim.opt.foldcolumn = 'auto'
		vim.opt.foldenable = true
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99

		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
		vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
		vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
		vim.keymap.set('n', '<C-a>', function()
			local winid = require('ufo').peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end)
	end,
	dependencies = {
		'kevinhwang91/promise-async',
	},
}

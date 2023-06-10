local ftMap = {
	git = '',
}

local hlgroup = 'NonText'
local function handler(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = '  ' .. '' .. '  ' .. tostring(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, hlgroup })
	return newVirtText
end

return {
	'kevinhwang91/nvim-ufo',
	event = 'BufReadPost',
	keys = {
		{ 'zR', function() require('ufo').openAllFolds() end },
		{ 'zM', function() require('ufo').closeAllFolds() end },
		{ 'zr', function() require('ufo').openFoldsExceptKinds() end },
		{ 'zm', function() require('ufo').closeFoldsWith() end },
	},
	opts = {
		filetype_exclude = { 'help', 'alpha', 'neo-tree', 'lazy', 'mason' },
		open_fold_hl_timeout = 0,
		provider_selector = function(_, filetype, _)
			return ftMap[filetype] or { 'lsp', 'indent' }
		end,
		close_fold_kinds = { 'imports', 'comment' },
		fold_virt_text_handler = handler,
		enable_get_fold_virt_text = true,
	},
	config = function(_, opts)
		vim.o.foldcolumn = '0'
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		require('ufo').setup(opts)
	end,
	dependencies = { 'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter' },
}

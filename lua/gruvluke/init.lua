local M = {}

M.load = function()
	if vim.g.colors_name then
		vim.cmd.hi 'clear'
	end

	vim.g.colors_name = 'gruvluke'
	vim.o.termguicolors = true

	local groups = require('gruvluke.groups').setup()

	for group, settings in pairs(groups) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M

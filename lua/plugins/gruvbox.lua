return {
	'sainnhe/gruvbox-material',
	lazy = false,
	priority = 1000,
	config = function()
		vim.api.nvim_set_var('gruvbox_material_background', 'hard')
		vim.api.nvim_set_var('gruvbox_material_foreground', 'material')
		vim.api.nvim_set_var('gruvbox_material_visual', 'red background')
		vim.api.nvim_set_var('gruvbox_material_current_word', 'bold')
		vim.api.nvim_set_var('gruvbox_material_statusline_style', 'original')
		vim.api.nvim_set_var('gruvbox_material_transparent_background', 2)
		vim.api.nvim_set_var('gruvbox_material_better_performance', 1)
		vim.api.nvim_set_var('gruvbox_material_colors_override', {
			bg3 = { '#181818', '237' }, -- whatever 234 means
		})
		vim.api.nvim_cmd({
			cmd = 'colorscheme',
			args = { 'gruvbox-material' },
			bang = false,
		}, {})
	end,
}

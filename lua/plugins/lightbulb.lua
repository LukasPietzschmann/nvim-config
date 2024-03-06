return {
	'kosayoda/nvim-lightbulb',
	event = 'LspAttach',
	opts = {
		sign = { enabled = true },
		autocmd = { enabled = true },
		hide_in_unfocused_buffer = false,
	},
}

return {
	'kosayoda/nvim-lightbulb',
	event = { 'BufReadPre', 'BufAdd' },
	opts = {
		sign = { enabled = true },
		autocmd = { enabled = true },
	},
}

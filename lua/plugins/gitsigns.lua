return {
	'lewis6991/gitsigns.nvim',
	event = { 'BufReadPre', 'BufAdd' },
	opts = {
		signs = {
			add = { text = '│' },
			change = { text = '│' },
			delete = { text = '│' },
			topdelete = { text = '‾' },
			changedelete = { text = '│' },
		},
		signcolumn = true,
		numhl = true,
		linehl = false,
		word_diff = false,
		watch_gitdir = { follow_files = true },
		attach_to_untracked = false,
		current_line_blame = false,
		sign_priority = 6,
		preview_config = { border = 'rounded' },
	},
	dependencies = { 'nvim-lua/plenary.nvim' },
}

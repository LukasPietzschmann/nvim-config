return {
	'lewis6991/gitsigns.nvim',
	event = { 'BufReadPre', 'BufAdd' },
	opts = {
		signs = {
			add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
			change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
			delete = { hl = 'GitSignsDelete', text = '│', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
			topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
			changedelete = {
				hl = 'GitSignsChange',
				text = '│',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn',
			},
		},
		signcolumn = true,
		numhl = true,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 5000,
			follow_files = true,
		},
		attach_to_untracked = false,
		current_line_blame = false,
		sign_priority = 6,
	},
	dependencies = { 'nvim-lua/plenary.nvim' },
}

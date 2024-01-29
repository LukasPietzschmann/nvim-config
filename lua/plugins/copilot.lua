return {
	'zbirenbaum/copilot.lua',
	cmd = 'Copilot',
	event = 'InsertEnter',
	build = ':Copilot auth',
	config = function(_, opts)
		require('copilot').setup(opts)
	end,
	opts = {
		panel = { enabled = false },
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = '<Tab>',
				dismiss = '<Esc>',
			},
		},
	},
}

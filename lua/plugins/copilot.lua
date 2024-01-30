return {
	'zbirenbaum/copilot.lua',
	cmd = 'Copilot',
	event = 'InsertEnter',
	build = ':Copilot auth',
	config = function(_, opts)
		require('copilot').setup(opts)
		local suggestion = require 'copilot.suggestion'
		vim.keymap.set('i', '<Esc>', function()
			if suggestion.is_visible() then
				suggestion.dismiss()
			end
			return '<Esc>'
		end, {
			desc = '[copilot] dismiss suggestion',
			expr = true,
			silent = true,
		})
	end,
	opts = {
		panel = { enabled = false },
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = false, -- handled by cmp
				dismiss = false,
				accept_word = false,
				accept_line = false,
				next = false,
				prev = false,
			},
		},
		filetypes = { ['*'] = true },
		server_opts_overrides = {
			settings = {
				advanced = {
					inlineSuggestCount = 1,
				},
			},
		},
	},
}

return {
	'zbirenbaum/copilot.lua',
	cmd = 'Copilot',
	event = 'InsertEnter',
	build = ':Copilot auth',
	config = function(_, opts)
		vim.api.nvim_create_autocmd('User', {
			pattern = 'BlinkCmpMenuOpen',
			desc = 'Hide the copilot suggestion when the completion menu is opened',
			group = HideCopilotOnCompletion,
			callback = function()
				vim.b.copilot_suggestion_hidden = true
			end,
		})

		vim.api.nvim_create_autocmd('User', {
			pattern = 'BlinkCmpMenuClose',
			desc = 'Show the copilot suggestion when the completion menu is closed',
			group = HideCopilotOnCompletion,
			callback = function()
				vim.b.copilot_suggestion_hidden = false
			end,
		})

		require('copilot').setup(opts)
		local suggestion = lazy_require 'copilot.suggestion'
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

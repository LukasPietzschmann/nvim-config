function Close_all_floating_wins()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= '' then
			vim.api.nvim_win_close(win, false)
		end
	end
end

return {
	'rmagatti/auto-session',
	cmd = { 'SessionSave', 'SessionRestore', 'SessionRestoreFromFile', 'SessionDelete', 'Autosession' },
	keys = { {
		'<A-o>',
		function()
			require('auto-session.session-lens').search_session()
		end,
	} },
	opts = {
		log_level = 'error',
		auto_session_enable_last_session = false,
		auto_session_create_enabled = false,
		session_lens = {
			load_on_setup = true,
			theme_conf = { border = true, winblend = 0 },
			previewer = false,
		},
		pre_save_cmds = { Close_all_floating_wins },
	},
	init = function()
		vim.o.sessionoptions = 'blank,buffers,curdir,folds,tabpages,localoptions,winsize'
	end,
	config = function(_, opts)
		require('auto-session').setup(opts)
		require('telescope').load_extension 'session-lens'
	end,
}

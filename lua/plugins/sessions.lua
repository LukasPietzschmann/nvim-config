return {
	'rmagatti/auto-session',
	cmd = { 'SessionSave', 'SessionRestore', 'SessionRestoreFromFile', 'SessionDelete', 'Autosession' },
	keys = { {
		'<A-o>',
		function()
			require('auto-session.session-lens').search_session {}
		end,
	} },
	opts = {
		log_level = 'error',
		auto_restore_last_session = false,
		auto_create = false,
		session_lens = {
			load_on_setup = true,
			theme_conf = { border = true, winblend = 0 },
			previewer = false,
		},
	},
	init = function()
		vim.o.sessionoptions = 'blank,buffers,curdir,folds,tabpages,localoptions,winsize'
	end,
	config = function(_, opts)
		require('auto-session').setup(opts)
		require('telescope').load_extension 'session-lens'
	end,
}

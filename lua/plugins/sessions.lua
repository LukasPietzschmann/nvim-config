return {
	'LukasPietzschmann/sessions.nvim',
	name = 'sessions.nvim',
	dev = true,
	cmd = { 'SessionsSave', 'SessionsLoad', 'SessionsStop', 'SessionsDelete' },
	config = function()
		require('sessions').setup()
	end,
}

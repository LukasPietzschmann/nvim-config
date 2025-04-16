return {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.env.VIMRUNTIME .. '/lua',
					table.unpack(vim.api.nvim_list_runtime_paths()),
				},
			},
			telemetry = { enable = false },
			diagnostics = {
				disable = { 'lowercase-global' },
			},
			hint = { enable = true },
		},
	},
}

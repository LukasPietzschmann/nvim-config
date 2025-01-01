return {
	'sphamba/smear-cursor.nvim',
	event = 'CursorMoved',
	opts = {
		legacy_computing_symbols_support = true,
		smear_between_neighbor_lines = false,
		smear_between_buffers = false,
		smear_to_cmd = false,
		time_interval = 20,
	},
}

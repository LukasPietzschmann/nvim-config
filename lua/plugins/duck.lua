return {
	'tamton-aquib/duck.nvim',
	keys = {
		{ '<C-e>h', function() require('duck').hatch() end },
		{ '<C-e>c', function() require('duck').cook() end },
	},
}

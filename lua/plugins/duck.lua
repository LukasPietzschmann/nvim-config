return {
	'tamton-aquib/duck.nvim',
	keys = {
		{ '<C-d>h', function() require('duck').hatch() end },
		{ '<C-d>c', function() require('duck').cook() end },
	},
}

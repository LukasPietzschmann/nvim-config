return {
	'tamton-aquib/duck.nvim',
	keys = {
		{ '<C-q>h', function() require('duck').hatch() end },
		{ '<C-q>c', function() require('duck').cook_all() end },
	},
}

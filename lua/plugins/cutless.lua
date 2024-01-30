return {
	'tenxsoydev/karen-yank.nvim',
	keys = {
		{ 'm', function() require('karen-yank.actions').cut('d') end, },
		{ 'M', function() require('karen-yank.actions').cut('D') end, },
		{ 'mm', 'dd', },
		{'d'}, {'md'}, {'D'}, {'mD'}, {'c'}, {'mc'}, {'y'}, {'yy'}, {'Y'}, {'p'}, {'P'}
	},
	opts = {
		karen = 'y',
		invert = false,
		disable = { 's', 'S' },
	},
}

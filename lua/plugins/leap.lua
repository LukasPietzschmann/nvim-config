return {
	url = 'https://codeberg.org/andyg/leap.nvim',
	keys = {
		{ 's', mode = 'n', desc = 'Leap forward', '<Plug>(leap-forward)' },
		{ 'S', mode = 'n', desc = 'Leap backward', '<Plug>(leap-backward)' },
	},
	config = function()
		local leap = require 'leap'
		leap.opts.case_sensitive = false
		leap.opts.equivalence_classes = { ' \t\r\n' }
		leap.opts.safe_labels = ''
		leap.opts.labels = 'asdfjklqweopmn,.äö'
	end,
}

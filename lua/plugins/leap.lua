return {
	'ggandor/leap.nvim',
	keys = { 's', 'S', 'x', 'X', 'gs', 'f', 'F' },
	config = function()
		local leap = require 'leap'
		leap.add_default_mappings()
		leap.opts.case_sensitive = false
		leap.opts.equivalence_classes = { ' \t\r\n' }
		leap.opts.safe_labels = ''
		leap.opts.labels = 'asdfjklqweopmn,.äö'
	end,
}

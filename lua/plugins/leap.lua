return {
	{
		'ggandor/leap.nvim',
		keys = { 's', 'S', 'x', 'X', 'gs', 'f', 'F' },
		config = function()
			local leap = require 'leap'
			leap.add_default_mappings()
			leap.opts.safe_labels = {}
			leap.opts.case_sensitive = false
			leap.opts.equivalence_classes = { ' \t\r\n' }
			leap.opts.labels = { 'w', 'a', 's', 'e', 'd', 'j', 'k', 'l' }
		end,
	},
	{
		'ggandor/flit.nvim',
		keys = { 'f', 'F', 't', 'T' },
		opts = {
			keys = { f = 'f', F = 'F', t = 't', T = 'T' },
			multiline = true,
		},
		dependencies = { 'ggandor/leap.nvim' },
	},
}

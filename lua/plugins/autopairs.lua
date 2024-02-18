return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	opts = {
		check_ts = true,
		enable_check_bracket_line = false,
	},
	config = function(_, opts)
		require('nvim-autopairs').setup(opts)
		local Rule = require 'nvim-autopairs.rule'
		local npairs = require 'nvim-autopairs'
		local cond = require 'nvim-autopairs.conds'

		npairs.add_rules {
			Rule('$', '$', { 'tex', 'plaintex', 'latex' })
				:with_pair(cond.not_before_regex '%%')
				:with_move(cond.none())
				:with_cr(cond.none()),
		}
	end,
}

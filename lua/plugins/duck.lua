return {
	'tamton-aquib/duck.nvim',
	init = function()
		vim.api.nvim_create_user_command('Duck', function(opts)
			local command = opts.args -- for one argument, args is the argument string
			if command == 'hatch' then
				require('duck').hatch()
			elseif command == 'cook' then
				require('duck').cook_all()
			else
				vim.notify('Invalid argument. Use "hatch" or "cook".', vim.log.levels.ERROR)
			end
		end, {
			nargs = 1,
			complete = function(_, _, _)
				return { 'hatch', 'cook' }
			end,
			desc = 'Hatch and cook Ducks',
		})
	end,
}

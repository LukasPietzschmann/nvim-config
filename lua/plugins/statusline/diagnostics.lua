local conditions = require 'heirline.conditions'

M = {}

M.Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { 'DiagnosticChanged', 'BufEnter', 'VimResized' },
	static = {
		error_icon = 'E:',
		warn_icon = 'W:',
		info_icon = 'I:',
		hint_icon = 'H:',
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	flexible = 30,
	{
		{
			provider = function(self)
				return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
			end,
		},
		{
			provider = function(self)
				return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
			end,
		},
		{
			provider = function(self)
				return self.info > 0 and (self.info_icon .. self.info .. ' ')
			end,
		},
		{
			provider = function(self)
				return self.hints > 0 and (self.hint_icon .. self.hints)
			end,
		},
		Space(2),
	},
	Empty,
}

return M

local conditions = require 'heirline.conditions'

M = {}

M.Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { 'DiagnosticChanged', 'BufEnter', 'VimResized' },
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	flexible = 30,
	{
		{
			condition = function(self)
				return self.errors > 0
			end,
			provider = function(self)
				return string.format('%s%s', icons.diagnostics.error, self.errors)
			end,
			Space(2),
		},
		{
			condition = function(self)
				return self.warnings > 0
			end,
			provider = function(self)
				return string.format('%s%s', icons.diagnostics.warning, self.warnings)
			end,
			Space(2),
		},
		{
			condition = function(self)
				return self.info > 0
			end,
			provider = function(self)
				return string.format('%s%s', icons.diagnostics.info, self.info)
			end,
			Space(2),
		},
		{
			condition = function(self)
				return self.hints > 0
			end,
			provider = function(self)
				return string.format('%s %s', icons.diagnostics.hint, self.hints)
			end,
			Space(2),
		},
	},
	Empty,
}

return M

local conditions = lazy_require 'heirline.conditions'

M = {}

M.LanguageServers = {
	condition = conditions.lsp_attached,
	update = { 'LspAttach', 'LspDetach', 'VimResized' },
	flexible = 10,
	{
		provider = function()
			local names = {}
			for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
				insert_set(names, server.name)
			end
			return string.format('%s[%s]', icons.tools.language_servers, table.concat(names, ', '))
		end,
		Space(2),
	},
	{
		provider = icons.tools.language_servers,
		Space(2),
	},
}

M.Linters = {
	condition = function(self)
		local loaded = is_plugin_loaded 'nvim-lint'
		if not loaded then
			return false
		end
		local linters = require('lint').linters_by_ft[vim.bo.filetype]
		if linters == nil or #linters <= 0 then
			return false
		end
		self.linters = linters
		return true
	end,
	flexible = 10,
	{
		provider = function(self)
			return string.format('%s [%s]', icons.tools.linters, table.concat(self.linters, ', '))
		end,
		Space(2),
	},
	{
		provider = icons.tools.linters,
		Space(2),
	},
}

M.Parsers = {
	condition = function(self)
		if not is_plugin_loaded 'nvim-treesitter' then
			return false
		end
		local parser = require('nvim-treesitter.parsers').get_parser()
		if parser == nil then
			return false
		end
		self.parser = parser
		return true
	end,
	flexible = 10,
	{
		provider = function(self)
			local names = {}
			self.parser:for_each_tree(function(_, tree)
				local lang = tree:lang()
				insert_set(names, lang)
			end)
			return string.format('%s [%s]', icons.tools.parsers, table.concat(names, ', '))
		end,
		Space(2),
	},
	{
		provider = icons.tools.parsers,
		Space(2),
	},
}

M.Formatter = {
	condition = function()
		local formatter_loaded = is_plugin_loaded 'conform.nvim'
		if not formatter_loaded then
			return false
		end
		local formatters = require('conform').list_formatters_to_run()
		formatters = vim.tbl_filter(function(f)
			return f.name ~= 'trim_whitespace'
		end, formatters)
		return #formatters > 0
	end,
	provider = icons.tools.formatter,
	Space(2),
}

M.AttachedTools = {
	flexible = 20,
	{
		M.Formatter,
		M.LanguageServers,
		M.Linters,
		M.Parsers,
	},
	Empty,
}

return M

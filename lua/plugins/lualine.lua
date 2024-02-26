local function get_search_count()
	local result = vim.fn.searchcount { maxcount = 99999 }
	if result.total > 0 then
		return string.format('[%d / %d]', result.current, result.total)
	end
	return ''
end

local function already_contained(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

local function attached_servers()
	local names = {}
	for _, server in pairs(vim.lsp.buf_get_clients(0)) do
		if not already_contained(names, server.name) then
			table.insert(names, server.name)
		end
	end
	if #names == 0 then
		return ''
	end
	return ' [' .. table.concat(names, ', ') .. ']'
end

local function attached_linters()
	if not Is_plugin_loaded 'nvim-lint' then
		return ''
	end

	local linters = require('lint').linters_by_ft[vim.bo.filetype]
	if linters == nil then
		return ''
	end
	return '󰍉 [' .. table.concat(linters, ', ') .. ']'
end

local function attached_parsers()
	local names = {}
	local parser = require('nvim-treesitter.parsers').get_parser()
	if parser == nil then
		return ''
	end
	parser:for_each_tree(function(_, tree)
		local lang = tree:lang()
		if not already_contained(names, lang) then
			table.insert(names, lang)
		end
	end)
	return '󰹩 [' .. table.concat(names, ', ') .. ']'
end

local function hide_or_trunc(trunc_width, trunc_len, no_ellipsis, hide)
	return function(str)
		local win_width = vim.fn.winwidth(0)
		if hide and hide(win_width) then
			return ''
		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
			return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
		end
		return str
	end
end

local function trunc(trunc_width, trunc_len, no_ellipsis)
	return hide_or_trunc(trunc_width, trunc_len, no_ellipsis, nil)
end

local function hide(hide_width, condition)
	return hide_or_trunc(nil, nil, nil, function(width)
		return condition() and width < hide_width
	end)
end

-- TODO: reload theme on background change
local get_theme = function(colors)
	return {
		normal = {
			a = { bg = colors.fg4, fg = colors.bg0, gui = 'bold' },
			b = { bg = colors.bg2, fg = colors.fg2 },
			c = { bg = colors.bg1, fg = colors.fg4 },
		},
		insert = {
			a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
			b = { bg = colors.bg2, fg = colors.fg2 },
			c = { bg = colors.bg1, fg = colors.fg4 },
		},
		visual = {
			a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
			b = { bg = colors.bg2, fg = colors.fg2 },
			c = { bg = colors.bg1, fg = colors.fg4 },
		},
		replace = {
			a = { bg = colors.red, fg = colors.black, gui = 'bold' },
			b = { bg = colors.bg2, fg = colors.fg2 },
			c = { bg = colors.bg1, fg = colors.fg4 },
		},
		command = {
			a = { bg = colors.green, fg = colors.black, gui = 'bold' },
			b = { bg = colors.bg2, fg = colors.fg2 },
			c = { bg = colors.bg1, fg = colors.fg4 },
		},
		inactive = {
			a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
			b = { bg = colors.bg2, fg = colors.fg2 },
			c = { bg = colors.bg1, fg = colors.fg4 },
		},
	}
end

return {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	init = function()
		vim.api.nvim_set_option_value('laststatus', 0, {})
	end,
	opts = function()
		local navic = require 'nvim-navic'
		local theme = get_theme(require('gruvluke.palette').get_base_colors())
		return {
			options = {
				theme = theme,
				component_separators = '|',
				section_separators = { left = '', right = '' },
				disabled_filetypes = { statusline = { 'alpha' } },
				globalstatus = true,
				refresh = {
					statusline = 5000,
					tabline = 5000,
					winbar = 5000,
				},
			},
			extensions = { 'lazy', 'man', 'mason', 'neo-tree', 'trouble' },
			sections = {
				lualine_a = { { 'mode', lowercase = false } },
				lualine_b = {
					{ require('auto-session.lib').current_session_name },
					{
						'branch',
						{
							'diff',
							colored = false,
						},
						fmt = trunc(10000, 10, false),
					},
				},
				lualine_c = {
					{
						function()
							return navic.get_location()
						end,
						cond = function()
							return navic.is_available()
						end,
					},
				},
				lualine_x = {
					{
						'diagnostics',
						colored = false,
						symbols = { error = 'E: ', warn = 'W: ', info = 'I: ', hint = 'H: ' },
					},
					{
						'copilot',
						show_colors = false,
						show_loading = true,
					},
					{
						attached_parsers,
						fmt = hide(140, navic.is_available),
					},
					{
						attached_linters,
						fmt = hide(140, navic.is_available),
					},
					{
						attached_servers,
						fmt = hide(140, navic.is_available),
					},
				},
				lualine_y = { get_search_count },
				lualine_z = { 'selectioncount', 'location', 'progress' },
			},
		}
	end,
	dependencies = {
		'nvim-tree/nvim-web-devicons',
		'SmiteshP/nvim-navic',
		'AndreM222/copilot-lualine',
	},
}

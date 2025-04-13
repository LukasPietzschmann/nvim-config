function lazy_require(require_path)
	return setmetatable({}, {
		__index = function(_, key)
			return require(require_path)[key]
		end,
		__newindex = function(_, key, value)
			require(require_path)[key] = value
		end,
		__call = function(_, ...)
			return require(require_path)(...)
		end,
	})
end
function is_plugin_loaded(name)
	local plugin = require('lazy.core.config').plugins[name]
	return plugin ~= nil and plugin._.loaded ~= nil
end

function is_contained_in(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function insert_set(tab, elem)
	if is_contained_in(tab, elem) then
		return
	end
	table.insert(tab, elem)
end

function startswith(str)
	return function(start)
		return str:sub(1, #start) == start
	end
end

function filter(tab, p)
	local result = {}
	for _, v in ipairs(tab) do
		if p(v) then
			table.insert(result, v)
		end
	end
	return result
end

function any(p, tab)
	for _, v in ipairs(tab) do
		if p(v) then
			return true
		end
	end
	return false
end

-- Created here, as utils.lua is loaded before everything else (especially before plugins)
CloseStuffBeforeExitGroup = vim.api.nvim_create_augroup('CloseStuffBeforeExit', { clear = true })
HideCopilotOnCompletion = vim.api.nvim_create_augroup('HideCopilotOnComp', { clear = true })

icons = {
	tools = {
		formatter = '󰉼',
		language_servers = ' ',
		linters = '󰍉',
		parsers = '󰹩',
	},
	copilot = {
		enabled = ' ',
		sleep = ' ',
		disabled = ' ',
		warning = ' ',
		unknown = ' ',
	},
	powerline = {
		slant_left = '',
		slant_left_thin = '',
		slant_right = '',
		slant_right_thin = '',
		----------------------------------------------
		slant_left_2 = '',
		slant_left_2_thin = '',
		slant_right_2 = '',
		slant_right_2_thin = '',
		----------------------------------------------
		left_rounded = '',
		left_rounded_thin = '',
		right_rounded = '',
		right_rounded_thin = '',
	},
	folder = {
		closed = '',
		open = '',
		empty = 'ﰊ',
	},
	arrow = {
		right = '',
		down = '',
	},
	diagnostics = {
		error = ' ',
		warning = ' ',
		info = ' ',
		hint = '',
	},
	save = ' ',
	new_file = ' ',
	find = ' ',
	clock = ' ',
	package = ' ',
	grid = ' ',
	bye = ' ',
	padlock = '',
	circle = '',
}

local theme_dark = {
	fill = { fg = '#a89984', bg = '#181818' },
	head = { fg = '#a89984', bg = '#32302f' },
	current_tab = { fg = '#181818', bg = '#a89984' },
	tab = { fg = '#a89984', bg = '#32302f' },
}

local theme_light = {
	fill = { fg = '#d5c4a1', bg = '#f9f5d7' },
	head = { fg = '#d5c4a1', bg = '#7c6f64' },
	current_tab = { fg = '#f9f5d7', bg = '#d5c4a1' },
	tab = { fg = '#d5c4a1', bg = '#7c6f64' },
}

local ternary = function(cond, T, F)
	if cond then
		return T
	else
		return F
	end
end

local tab_name = function(tab)
	local api = require 'tabby.module.api'
	local cur_win = api.get_tab_current_win(tab.id)
	if api.is_float_win(cur_win) then
		return '[Floating]'
	end
	local current_bufnr = vim.fn.getwininfo(cur_win)[1].bufnr
	local current_bufinfo = vim.fn.getbufinfo(current_bufnr)[1]
	local current_buf_name = vim.fn.fnamemodify(current_bufinfo.name, ':t')
	if current_buf_name == '' then
		return '[Empty]'
	else
		return current_buf_name
	end
end

local change_mark = function(tab)
	local already_marked = false
	return tab.wins().foreach(function(win)
		local bufnr = vim.fn.getwininfo(win.id)[1].bufnr
		local bufinfo = vim.fn.getbufinfo(bufnr)[1]
		if not already_marked and bufinfo.changed == 1 then
			already_marked = true
			return '[+]'
		else
			return ''
		end
	end)
end

local window_count = function(tab)
	local api = require 'tabby.module.api'
	local win_count = #api.get_tab_wins(tab.id)
	if win_count == 1 then
		return ''
	else
		return '[' .. win_count .. ']'
	end
end

return {
	'nanozuki/tabby.nvim',
	event = 'VeryLazy',
	config = function()
		local theme = ternary(vim.api.nvim_get_option 'background' == 'light', theme_light, theme_dark)
		require('tabby.tabline').set(function(line)
			return {
				{
					{ ' 😻 ', hl = theme.head },
					line.sep('', theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep('', hl, theme.fill),
						change_mark(tab),
						tab_name(tab),
						window_count(tab),
						line.sep('', hl, theme.fill),
						hl = hl,
						margin = ' ',
					}
				end),
				hl = theme.fill,
			}
		end, {
			buf_name = {
				mode = 'unique',
			},
		})
	end,
}

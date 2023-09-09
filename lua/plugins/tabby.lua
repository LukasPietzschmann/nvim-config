local theme = {
	fill = 'TabLineFill',
	head = 'TabLine',
	current_tab = 'TabLineSel',
	tab = 'TabLine',
	win = 'TabLine',
	tail = 'TabLine',
}

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
		require('tabby.tabline').set(function(line)
			return {
				{
					{ ' 😻 ', hl = theme.head },
					line.sep(' ', theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep('', hl, theme.fill),
						change_mark(tab),
						tab_name(tab),
						window_count(tab),
						line.sep(' ', hl, theme.fill),
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

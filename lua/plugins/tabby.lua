local theme = {
	fill = 'TabLineFill',
	head = 'TabLine',
	current_tab = 'TabLineSel',
	tab = 'TabLine',
	current_win = 'TabWinSel',
	win = 'TabWin',
	tail = 'TabLine',
}

local function get_tab_modifiers(tab)
	local api = require 'tabby.module.api'
	local wins = api.get_tab_wins(tab.id)
	local one_has_changed = false
	for _, win in pairs(wins) do
		local buf = api.get_win_buf(win)
		if api.get_buf_is_changed(buf) then
			one_has_changed = true
			break
		end
	end
	local results = {}
	if one_has_changed then
		table.insert(results, '+')
	end
	if #wins > 1 then
		table.insert(results, #wins)
	end
	if #results == 0 then
		return ''
	else
		return '[' .. table.concat(results, ',') .. '] '
	end
end

local function get_win_modifiers(win)
	local expanded_modifiers = vim.api.nvim_eval_statusline('[%M%R%H%W] ', { winid = win.id })
	if expanded_modifiers.width > 3 then
		return expanded_modifiers.str
	else
		return ''
	end
end

local function should_show_windows(tab)
	local api = require 'tabby.module.api'
	local wins = api.get_tab_wins(tab.id)
	return tab.is_current() and #wins > 1
end

local function render_tab(line, content, is_current, are_windows_shown)
	if are_windows_shown then
		return ''
	end
	local hl = is_current and theme.current_tab or theme.tab
	return {
		line.sep('', hl, theme.fill),
		content,
		line.sep(' ', hl, theme.fill),
		hl = hl,
		margin = ' ',
	}
end

local function render_window(line, content, is_current, is_first, is_last)
	local hl = is_current and theme.current_win or theme.win
	return {
		is_first and line.sep('', hl, theme.fill) or line.sep('', hl, theme.fill),
		content,
		is_last and line.sep(' ', hl, theme.fill) or line.sep('', hl, theme.fill),
		hl = hl,
		margin = ' ',
	}
end

local function foreach(t, fn)
	local results = {}
	for _, v in ipairs(t) do
		local results_size = #results
		results[results_size + 1] = fn(results_size == 0, results_size + 1 == #t, v)
	end
	return results
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
					local are_windows_shown = should_show_windows(tab)
					return {
						render_tab(line, {
							get_tab_modifiers(tab),
							tab.name(),
						}, tab.is_current(), are_windows_shown),
						are_windows_shown and foreach(
							line.wins_in_tab(line.api.get_current_tab()).wins,
							function(is_first, is_last, win)
								return render_window(line, {
									get_win_modifiers(win),
									win.buf_name(),
								}, win.is_current(), is_first, is_last)
							end
						) or '',
					}
				end),
				hl = theme.fill,
			}
		end, {
			buf_name = {
				mode = 'unique',
			},
			tab_name = {
				name_fallback = function(tabid)
					local api = require 'tabby.module.api'
					local cur_win = api.get_tab_current_win(tabid)
					if api.is_float_win(cur_win) then
						return '[Floating]'
					else
						return require('tabby.feature.buf_name').get(cur_win)
					end
				end,
			},
		})
	end,
}

local helpers = require 'plugins.statusline.helpers'
local Space = helpers.Space
local icons = helpers.icons

local function lazy_require(require_path)
	return setmetatable({}, {
		__index = function(_, key)
			return require(require_path)[key]
		end,

		__newindex = function(_, key, value)
			require(require_path)[key] = value
		end,
	})
end

local client = lazy_require 'copilot.client'
local api = lazy_require 'copilot.api'

M = {}

local function is_current_buffer_attached()
	return client.buf_is_attached(vim.api.nvim_get_current_buf())
end

local function is_enabled()
	if client.is_disabled() then
		return false
	end

	if not is_current_buffer_attached() then
		return false
	end

	return true
end

local function is_error()
	if client.is_disabled() then
		return false
	end

	if not is_current_buffer_attached() then
		return false
	end

	local data = api.status.data.status
	if data == 'Warning' then
		return true
	end

	return false
end

local function is_loading()
	if client.is_disabled() then
		return false
	end

	if not is_current_buffer_attached() then
		return false
	end

	local data = api.status.data.status
	if data == 'InProgress' then
		return true
	end

	return false
end

local function is_sleep()
	if client.is_disabled() then
		return false
	end

	if not is_current_buffer_attached() then
		return false
	end

	if vim.b.copilot_suggestion_auto_trigger == nil then
		return require('copilot.config').get('suggestion').auto_trigger
	end
	return vim.b.copilot_suggestion_auto_trigger
end

local attached = false
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('copilot-status', {}),
	desc = 'Update copilot attached status',
	callback = function(args)
		local new_client = vim.lsp.get_client_by_id(args.data.client_id)
		if new_client and new_client.name == 'copilot' then
			attached = true
			vim.api.nvim_exec_autocmds('User', { pattern = 'CopilotStatus' })
			api.register_status_notification_handler(function()
				vim.api.nvim_exec_autocmds('User', { pattern = 'CopilotStatus' })
			end)
			return true
		end
		return false
	end,
})

M.Copilot = {
	update = {
		'User',
		pattern = 'CopilotStatus',
		callback = function()
			vim.cmd 'redrawstatus'
		end,
	},
	provider = function()
		if not attached or not Is_plugin_loaded 'copilot.lua' then
			return icons.copilot.unknown
		elseif is_loading() then
			return '…'
		elseif is_error() then
			return icons.copilot.warning
		elseif not is_enabled() then
			return icons.copilot.disabled
		elseif is_sleep() then
			return icons.copilot.sleep
		else
			return icons.copilot.enabled
		end
	end,
	Space(2),
}

return M

local client = lazy_require 'copilot.client'
local status = lazy_require 'copilot.status'

M = {}

local function is_current_buffer_attached()
	return client.buf_is_attached(vim.api.nvim_get_current_buf())
end

local function is_enabled()
	return not client.is_disabled() and is_current_buffer_attached()
end

local function is_error()
	if not is_enabled() then
		return false
	end

	local status = status.data.status
	return status == 'Warning'
end

local function is_loading()
	if not is_enabled() then
		return false
	end

	local status = status.data.status
	return status == 'InProgress'
end

local function is_sleep()
	if not is_enabled() then
		return false
	end

	if vim.b.copilot_suggestion_auto_trigger ~= nil then
		return vim.b.copilot_suggestion_auto_trigger
	end
	return require('copilot.config').suggestion.auto_trigger
end

local attached = false
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('copilot-status', { clear = true }),
	desc = 'Update copilot attached status',
	callback = function(args)
		local new_client = vim.lsp.get_client_by_id(args.data.client_id)
		if new_client and new_client.name == 'copilot' then
			attached = true
			vim.api.nvim_exec_autocmds('User', { pattern = 'CopilotStatus' })
			status.register_status_notification_handler(function(data)
				vim.api.nvim_exec_autocmds('User', { pattern = 'CopilotStatus', data = data })
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
		if not attached or not is_plugin_loaded 'copilot.lua' or not is_enabled() then
			return icons.copilot.disabled
		elseif is_loading() then
			return '…'
		elseif is_error() then
			return icons.copilot.warning
		elseif is_sleep() then
			return icons.copilot.sleep
		elseif is_enabled() then
			return icons.copilot.enabled
		else
			return icons.copilot.unknown
		end
	end,
	Space(2),
}

return M

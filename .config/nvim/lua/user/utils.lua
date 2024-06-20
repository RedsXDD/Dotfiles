local M = {}

---@type {k:string, v:any}[]
M._maximized = nil
---@param state boolean?
function M.maximize(state)
	if state == (M._maximized ~= nil) then
		return
	end

	if M._maximized then
		for _, opt in ipairs(M._maximized) do
			vim.o[opt.k] = opt.v
		end
		M._maximized = nil
		vim.cmd("wincmd =")
	else
		M._maximized = {}
		local function set(k, v)
			table.insert(M._maximized, 1, { k = k, v = vim.o[k] })
			vim.o[k] = v
		end
		set("winwidth", 999)
		set("winheight", 999)
		set("winminwidth", 0)
		set("winminheight", 0)
		vim.cmd("wincmd =")
	end

	-- `QuitPre` seems to be executed even if we quit a normal window, so we don't want that
	-- `VimLeavePre` might be another consideration? Not sure about differences between the 2
	vim.api.nvim_create_autocmd("ExitPre", {
		once = true,
		group = vim.api.nvim_create_augroup("augroup_restore_max_exit_pre", { clear = true }),
		desc = "Restore width/height when close Neovim while maximized.",
		callback = function()
			M.maximize(false)
		end,
	})
end

return M

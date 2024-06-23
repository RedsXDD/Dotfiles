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

function M.toggle_netrw()
	pcall(require, "netrw") -- Try loading netrw.nvim if it's installed.

	local netrw_winsize = vim.g.netrw_winsize or 30

	local bufnr = vim.api.nvim_get_current_buf()
	local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

	if vim.g.netrw_is_open and filetype == "netrw" then
		vim.api.nvim_buf_delete(0, { force = true })
		vim.g.netrw_is_open = false
	else
		vim.g.netrw_is_open = true
		vim.cmd("Lexplore")
		vim.cmd("vertical resize " .. netrw_winsize)
	end
end

---@param chdir boolean?
function M.toggle_file_explorer(chdir)
	local has_neotree, neotree = pcall(require, "neo-tree.command")
	local has_minifiles, files = pcall(require, "mini.files")

	if type(chdir) == "boolean" and chdir == true then
		local filepath = vim.api.nvim_buf_get_name(0)
		local current_directory = vim.fs.dirname(filepath)
		vim.fn.chdir(current_directory)
	end

	local toggle_mini_files = function(path, use_lastest)
		if not files.close() then
			files.open(path, use_lastest)
		end
	end

	---@diagnostic disable-next-line: undefined-field
	local directory_path = vim.uv.cwd()

	if has_neotree then
		neotree.execute({ toggle = true, dir = directory_path })
	elseif has_minifiles then
		toggle_mini_files(directory_path, true)
	else
		M.toggle_netrw()
	end
end

return M

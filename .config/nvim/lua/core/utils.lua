local M = {}
M.keymaps = {}

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

---@param directory_path string?
function M.toggle_netrw(directory_path)
	if directory_path == nil then
		---@diagnostic disable-next-line: undefined-field
		directory_path = vim.uv.cwd()
	end

	local netrw_winsize = (vim.g.netrw_winsize ~= nil) and vim.g.netrw_winsize or 30

	local bufnr = vim.api.nvim_get_current_buf()
	local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

	if vim.g.netrw_is_open and filetype == "netrw" then
		vim.g.netrw_is_open = false
		vim.api.nvim_buf_delete(0, { force = true })
	elseif vim.g.netrw_is_open then
		vim.g.netrw_is_open = false
		vim.cmd("Lexplore")
	else
		vim.g.netrw_is_open = true
		vim.cmd("Lexplore" .. directory_path .. "|" .. "vertical resize " .. netrw_winsize)
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

	if has_neotree and not type(neotree) == "boolean" then
		neotree.execute({ toggle = true, dir = directory_path })
	elseif has_minifiles and not type(files) == "boolean" then
		toggle_mini_files(directory_path, true)
	else
		M.toggle_netrw()
	end
end

---@param modes string|table
---@param keys string
---@param func string|function
---@param desc string
---@param opts table?
function M.keymaps.map(modes, keys, func, desc, opts)
	if opts ~= nil and type(opts) ~= "table" then
		error("expect table under 'opts' for keymap set but got " .. type(opts))
	end

	opts = opts or { noremap = true }
	opts.desc = "" .. desc

	vim.keymap.set(modes, keys, func, opts)
end

---@param keys string
---@param desc string
function M.keymaps.center_map(keys, desc)
	vim.keymap.set("", keys, keys .. "<CMD>norm! zvzz<CR>", { noremap = true, silent = true, desc = "" .. desc })
end

---@param actions table
---@param desc string
function M.keymaps.pum_map(actions, desc)
	if type(actions) ~= "table" then
		error("Could not find `table` for `pum_map()`.")
	end

	if actions.key == nil then
		actions.key = actions.normal
	end

	vim.keymap.set("i", actions.key, function()
		return vim.fn.pumvisible() ~= 0 and actions.pum or actions.normal
	end, { noremap = true, silent = true, expr = true, desc = "" .. desc })
end

---@param modes string|table
---@param keys string
---@param options string|table
---@param desc string
function M.keymaps.toggle_map (modes, keys, options, desc)
	vim.keymap.set(modes, keys, function()
		local state = false

		if type(options) == "string" then
			state = vim.o[options]
			state = not state
			vim.o[options] = state
		end

		if type(options) == "table" then
			for _, option in ipairs(options) do
				state = vim.o[option]
				state = not state
				vim.o[option] = state
			end
		end

		vim.notify(state and "Enabled " .. desc or "Disabled " .. desc, state and vim.log.levels.INFO or vim.log.levels.WARN)
	end, { noremap = true, silent = true, desc = "Toggle " .. desc })
end

---@param modes string|table
---@param keys string
---@param option string
---@param str string
---@param desc string
function M.keymaps.toggleStr_map (modes, keys, option, str, desc)
	vim.keymap.set(modes, keys, function()
		local has_str = vim.o[option]:find("" .. str) ~= nil
		vim.opt[option] = has_str and vim.o[option]:gsub("" .. str, "") or vim.o[option] .. "" .. str
		vim.notify(has_str and "Disabled " .. desc or "Enabled " .. desc, has_str and vim.log.levels.WARN or vim.log.levels.INFO)
	end, { noremap = true, silent = true, desc = "Toggle " .. desc })

end
return M

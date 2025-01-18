local M = { keymaps = {} }

---@param chdir boolean?
function M.toggle_file_explorer(chdir)
    if type(chdir) == "boolean" and chdir == true then
        local filepath = vim.api.nvim_buf_get_name(0)
        local current_directory = vim.fs.dirname(filepath)
        vim.fn.chdir(current_directory)
    end

    ---@diagnostic disable-next-line: undefined-field
    local directory_path = vim.uv.cwd()

    vim.fn.chdir("/tmp") -- Prevent `require` from loading local files.
    local has_minifiles, files = pcall(require, "mini.files")
    vim.fn.chdir(directory_path)

    if not has_minifiles then vim.notify("Mini.files could not be found.", vim.log.levels.ERROR) end
    if not files.close() then files.open(directory_path, true) end
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
    if type(actions) ~= "table" then error("Could not find `table` for `pum_map()`.") end

    if actions.key == nil then actions.key = actions.normal end

    vim.keymap.set(
        "i",
        actions.key,
        function() return vim.fn.pumvisible() ~= 0 and actions.pum or actions.normal end,
        { noremap = true, silent = true, expr = true, desc = "" .. desc }
    )
end

---@param modes string|table
---@param keys string
---@param options string|table
---@param desc string
function M.keymaps.toggle_map(modes, keys, options, desc)
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

        vim.notify(
            state and "Enabled " .. desc or "Disabled " .. desc,
            state and vim.log.levels.INFO or vim.log.levels.WARN
        )
    end, { noremap = true, silent = true, desc = "Toggle " .. desc })
end

---@param modes string|table
---@param keys string
---@param option string
---@param str string
---@param desc string
function M.keymaps.toggleStr_map(modes, keys, option, str, desc)
    vim.keymap.set(modes, keys, function()
        local has_str = vim.o[option]:find("" .. str) ~= nil
        vim.opt[option] = has_str and vim.o[option]:gsub("" .. str, "") or vim.o[option] .. "" .. str
        vim.notify(
            has_str and "Disabled " .. desc or "Enabled " .. desc,
            has_str and vim.log.levels.WARN or vim.log.levels.INFO
        )
    end, { noremap = true, silent = true, desc = "Toggle " .. desc })
end

return M

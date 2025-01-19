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
function M.map(modes, keys, func, desc, opts)
    if opts ~= nil and type(opts) ~= "table" then
        error("expect table under 'opts' for keymap set but got " .. type(opts))
    end

    opts = opts or { noremap = true }
    opts.desc = "" .. desc

    vim.keymap.set(modes, keys, func, opts)
end

return M

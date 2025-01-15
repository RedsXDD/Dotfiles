local has_files, files = pcall(require, "mini.files")
if not has_files then return end

-- Toggle dotfiles
local show_dotfiles = true

local filter_show = function() return true end
local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    files.refresh({ content = { filter = new_filter } })
end

-- Open files in splits
local map_split = function(buf_id, keys, direction)
    local split_function = function()
        -- Make new window and set it as target.
        local new_target_window
        vim.api.nvim_win_call(files.get_target_window(), function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
        end)

        files.set_target_window(new_target_window)
    end

    -- Adding `desc` will result into `show_help` entries.
    local desc = "Split " .. direction
    vim.keymap.set("n", keys, split_function, { buffer = buf_id, desc = desc })
end

-- Set current working directory
local files_set_cwd = function()
    -- Works only if cursor is on the valid file system entry.
    local cur_entry_path = files.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    vim.fn.chdir(cur_directory)
end

-- Window options
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
        local win_id = args.data.win_id
        -- vim.wo[win_id].winblend = 90 -- Window opacity.
        vim.api.nvim_win_set_config(win_id, { border = require("core.icons").misc.border })
    end,
})

-- Custom keymaps:
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles displaying." })
        vim.keymap.set("n", "g,", files_set_cwd, { buffer = buf_id })
        map_split(buf_id, "gs", "belowright horizontal")
        map_split(buf_id, "gv", "belowright vertical")
        map_split(buf_id, "_", "belowright horizontal")
        map_split(buf_id, "-", "belowright vertical")
    end,
})

files.setup({
    content = {
        -- Use different directory icon.
        prefix = function(fs_entry)
            -- Disable icons if Neovim is being ran on a TTY.
            if vim.env.DISPLAY == nil then return end

            local directory_icon = require("core.icons").mini_files.directory_icon
            if fs_entry.fs_type == "directory" then return directory_icon, "MiniFilesDirectory" end
            return require("mini.files").default_prefix(fs_entry)
        end,
    },
    windows = {
        max_number = math.huge, -- Maximum number of windows to show side by side.
        preview = true, -- Whether to show preview of file/directory under cursor.
        width_focus = 25, -- Width of focused window.
        width_nofocus = 15, -- Width of non-focused window.
        width_preview = 120, -- Width of preview window.
    },
    options = {
        permanent_delete = false, -- Whether to delete permanently or move into module-specific trash.

        -- Whether to use for editing directories.
        -- Disabled by default because init function already loads mini.files
        -- when opening directories.
        use_as_default_explorer = false,
    },
    mappings = {
        close = "q",
        go_in = "l",
        go_in_plus = "<CR>", -- Close explorer after opening file.
        go_out = "h",
        go_out_plus = "",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
    },
})

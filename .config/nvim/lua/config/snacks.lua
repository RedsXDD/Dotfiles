local has_snacks, snacks = pcall(require, "snacks")
if not has_snacks then return end

local icons = require("core.icons").dashboard

---@param icon string
---@param key string
---@param desc string
---@param action function
local function new_section(icon, key, desc, action) return { icon = icon, key = key, desc = desc, action = action } end

snacks.setup({
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = false },
    dashboard = {
        enabled = true,
        width = 45,
        preset = {
            header = (function()
                local logo = ""

                for _, line in ipairs(icons.header) do
                    logo = logo .. "\n" .. line
                end

                return logo
            end)(),
            --stylua: ignore
            keys = {
                new_section(icons.new_file, "n", "New File", function() vim.cmd([[enew | startinsert]]) end),
                new_section(icons.quit, "q", "Quit Neovim", function() vim.cmd([[qa!]]) end),
                new_section(icons.file_explorer, "e", "Open File Explorer", function() require("core.utils").toggle_file_explorer() end),
                new_section(icons.recent_files, "o", "Recent Files", function() snacks.dashboard.pick("oldfiles") end),
                new_section(icons.find_files, "f", "Find Files", function() snacks.dashboard.pick("files") end),
                new_section(icons.config_files, "c", "Config Files", function() snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") }) end),
                new_section(icons.live_grep, "g", "Live Grep", function() snacks.dashboard.pick("live_grep") end),
                { icon = icons.sessions, key = "s", desc = "Restore Session", section = "session" },
                new_section(icons.lazy, "l", "Open Lazy.nvim", function() vim.cmd([[Lazy]]) end),
                new_section(icons.mason, "m", "Open Mason", function() vim.cmd([[Mason]]) end),
            },
        },
        sections = {
            { section = "header" },
            { icon = icons.keymaps, title = "Keymaps", section = "keys", indent = 2, padding = { 2, 0 } },
            {
                icon = icons.recent_files,
                title = "Recent Files",
                section = "recent_files",
                indent = 2,
                padding = { 2, 0 },
            },
            { icon = icons.projects, title = "Projects", section = "projects", indent = 2, padding = { 2, 0 } },
            { icon = icons.footer, section = "startup" },
        },
    },
    debug = { enabled = false },
    dim = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    indent = { enabled = true },
    input = {
        enabled = true,
        backdrop = true,
        position = "float",
        border = "rounded",
        title_pos = "center",
        height = 1,
        width = 60,
        relative = "editor",
        noautocmd = true,
        row = 2,
        -- relative = "cursor",
        -- row = -3,
        -- col = 0,
        wo = {
            winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
            cursorline = false,
        },
        bo = {
            filetype = "snacks_input",
            buftype = "prompt",
        },
        --- buffer local variables
        b = {
            completion = false, -- disable blink completions in input
        },
        keys = {
            n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
            i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
            i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i", expr = true },
            i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
            i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
            q = "cancel",
        },
    },
    lazygit = { enabled = true },
    notifier = {
        enabled = true,
        timeout = 3000,
    },
    notify = { enabled = true },
    profiler = { enabled = false },
    quickfile = { enabled = true },
    rename = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = true },
    zen = { enabled = true },
    styles = {
        notification = {
            -- wo = { wrap = true } -- Wrap notifications
        },
    },
})

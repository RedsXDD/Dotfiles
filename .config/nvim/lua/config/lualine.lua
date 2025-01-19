local has_lualine, lualine = pcall(require, "lualine")
if not has_lualine then return end

local icons = require("core.icons")
local location_fn = function() return "ln:" .. "%l" .. " " .. "cl:" .. "%v" end

local opts = {
    options = {
        theme = "neopywal",
        icons_enabled = true,
        always_divide_middle = true,
        component_separators = "|",
        disabled_filetypes = {
            statusline = {
                "snacks_dashboard",
                "dashboard",
                "alpha",
                "starter",
            },
        },
    },
    extensions = {
        "lazy",
        "man",
        "mason",
        "neo-tree",
    },
}

local global_sections = {
    sections = {
        lualine_b = {
            "filetype",
            "filesize",
            "filename",
        },
        lualine_c = {
            "branch",
            {
                "diff",
                symbols = {
                    added = icons.git.added,
                    modified = icons.git.modified,
                    removed = icons.git.removed,
                },
                diff_color = {
                    added = "LuaLineDiffAdd",
                    modified = "LuaLineDiffChange",
                    removed = "LuaLineDiffDelete",
                },
                source = function()
                    local summary = vim.b.minidiff_summary
                    if summary then
                        return {
                            added = summary.add,
                            modified = summary.change,
                            removed = summary.delete,
                        }
                    end
                end,
            },
            {
                "diagnostics",
                symbols = {
                    error = icons.diagnostics.Error,
                    warn = icons.diagnostics.Warn,
                    info = icons.diagnostics.Info,
                    hint = icons.diagnostics.Hint,
                },
            },
        },
        lualine_x = {
            {
                require("noice").api.status.mode.get,
                cond = require("noice").api.status.mode.has,
                color = "LuaLineNoiceKeys",
            },
            {
                require("noice").api.status.command.get,
                cond = require("noice").api.status.command.has,
                color = "LuaLineNoiceKeys",
            },
        },
    },
}

local theme = {
    options = {
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "", right = "" }, padding = { left = 0, right = 0 } },
        },
        lualine_y = {
            "encoding",
            { "fileformat", icons_enabled = false },
            { "progress" },
        },
        lualine_z = {
            {
                location_fn,
                separator = { left = "", right = "" },
                padding = { left = 0, right = 0 },
            },
        },
    },
}

local tty_theme = {
    options = {
        section_separators = "",
        icons_enabled = false,
    },
    sections = {
        lualine_a = {
            "mode",
        },
        lualine_y = {
            "encoding",
            "fileformat",
            "progress",
        },
        lualine_z = {
            location_fn,
        },
    },
}

-- Use different themes if Neovim is being ran on a TTY enviroment or not.
local config = vim.tbl_deep_extend("force", opts, global_sections, vim.env.DISPLAY ~= nil and theme or tty_theme)

lualine.setup(config)

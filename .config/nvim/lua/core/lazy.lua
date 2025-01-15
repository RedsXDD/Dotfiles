-- Set leader key:
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy.vim installation:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local has_lazy, lazy = pcall(require, "lazy")
if not has_lazy then return end

-- Add support for the LazyFile event:
local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- Initialize lazy.nvim:
lazy.setup({
    spec = "core.plugins",
    defaults = {
        lazy = true,
        version = false, -- Always use the latest git commit.
        -- version = "*", -- Try installing the latest stable version for plugins that support semver.
    },
    install = {
        colorscheme = { "neopywal" },
    },
    checker = {
        enabled = true, -- Automatically check for plugin updates.
        notify = true, -- Turn on/off notifications whenever plugin updates are avaliable.
    },
    change_detection = {
        enabled = true, -- Automatically check for config file changes and reload the ui.
        notify = true, -- Turn on/off notifications whenever plugin changes are made.
    },
    ui = {
        border = require("core.icons").misc.border,
        title = "Lazy.nvim",
        icons = require("core.icons").lazy,
    },
    performance = {
        rtp = {
            -- Disable some rtp plugins:
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    profiling = {
        -- Enables extra stats on the debug tab related to the loader cache.
        -- Additionally gathers stats about all package.loaders
        loader = true,
        -- Track each new require in the Lazy profiling tab
        require = true,
    },
})

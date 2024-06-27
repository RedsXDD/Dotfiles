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

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Add support for the LazyFile event:
local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- Initialize lazy.nvim:
lazy.setup("core.plugins", {
	defaults = {
		lazy = true,
		version = false, -- Always use the latest git commit.
		-- version = "*", -- Try installing the latest stable version for plugins that support semver.
	},
	install = {
		missing = true,
		colorscheme = { "neopywal", "sorbet" },
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
		browser = "LibreWolf",
		wrap = true,
		border = require("core.icons").misc.border,
	},
	performance = {
		cache = { enabled = true },
		reset_packpath = true,
		rtp = {
			reset = true,
			paths = {},
			-- Disable some rtp plugins:
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

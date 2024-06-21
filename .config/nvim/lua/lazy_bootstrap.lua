-- Set leader key:
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy.vim installation:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

-- Initialize lazy.nvim:
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.mini" },
	},
	defaults = {
		lazy = false,
		version = false, -- Always use the latest git commit.
		-- version = "*", -- Try installing the latest stable version for plugins that support semver.
	},
	install = {
		colorscheme = { "neopywal" },
	},
	-- Automatically check for plugin updates.
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		enabled = true, -- Automatically check for config file changes and reload the ui.
		notify = false, -- Turn on/off notifications whenever plugin changes are made.
	},
	performance = {
		rtp = {
			-- Disable some rtp plugins:
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

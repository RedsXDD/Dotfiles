local border_style = require("core.icons").misc.border
local icons = require("core.icons").mason
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

vim.keymap.set("n", "<Leader>gm", "<CMD>Mason<CR>", { noremap = true, desc = "Open Mason UI." })

mason.setup({
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
	ui = {
		border = border_style,
		icons = {
			package_installed = icons.installed,
			package_pending = icons.pending,
			package_uninstalled = icons.uninstalled,
		},
	},
})

mason_lspconfig.setup({})
mason_tool_installer.setup({
	ensure_installed = {
		"taplo",
		"stylua",
		"lua_ls",
		"bashls",
		"clangd",
		"yamlls",
		"rust-analyzer",
		"shfmt",
		"prettier",
		"eslint_d",
		"isort",
		"black",
		"pylint",
	},
})

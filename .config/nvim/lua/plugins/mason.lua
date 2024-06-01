return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<Leader>gm", "<CMD>Mason<CR>", desc = "Open Mason UI." },
	},
	cmd = "Mason",
	build = ":MasonUpdate",
	config = function()
		local border_style = require("user.icons").icons.misc.border
		local icons = require("user.icons").icons.mason
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

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
			},
		})
	end,
}

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	cmd = "Mason",
	build = ":MasonUpdate",
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"lua_ls",
				"bashls",
				"clangd",
				"yamlls",
			},
		})

		-- mason_tool_installer.setup({ ensure_installed = mason_list })
		mason_tool_installer.setup({
			ensure_installed = {
				"eslint_d",
				"pylint",
				"stylua",
				"prettier",
				"black",
				"isort",
			}
		})
	end,
}

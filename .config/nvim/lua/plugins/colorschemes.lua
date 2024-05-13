return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
	},
	{
		"RedsXDD/neopywal.nvim",
		branch = "testing",
		name = "neopywal",
		lazy = false,
		priority = 1000,
		opts = {
			use_wallust = true,
			default_fileformats = false,
			default_plugins = false,
			plugins = {
				nvim_cmp = true,
				lazy = true,
				lspconfig = true,
				neotree = true,
				treesitter = true,
				mini = {
					cursorword = true,
					files = true,
					hipatterns = true,
					indentscope = true,
					pick = true,
					starter = true,
					statusline = true,
					tabline = true,
				},
			},
		},
		config = function(_, opts)
			local neopywal = require("neopywal")
			neopywal.setup(opts)

			if vim.env.DISPLAY ~= nil then
				vim.cmd.colorscheme("neopywal")
			else
				vim.cmd([[set notermguicolors]])
				vim.cmd.colorscheme("default")
			end
		end,
	},
}

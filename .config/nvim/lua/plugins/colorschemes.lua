return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
		opts = {},
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
			default_fileformats = false,
			default_plugins = false,
			plugins = {
				treesitter = true,
				lspconfig = true,
				nvim_cmp = true,
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
		config = function()
			if vim.env.DISPLAY ~= nil then
				vim.cmd.colorscheme("neopywal")
			else
				vim.cmd([[set notermguicolors]])
				vim.cmd.colorscheme("default")
			end
		end,
	},
}

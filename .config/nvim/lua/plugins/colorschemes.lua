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
		opts = { default_fileformats = false },
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

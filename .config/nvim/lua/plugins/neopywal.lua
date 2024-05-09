return {
	"RedsXDD/neopywal.nvim",
	name = "neopywal",
	lazy = false,
	priority = 1000,
	opts = {},
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
}

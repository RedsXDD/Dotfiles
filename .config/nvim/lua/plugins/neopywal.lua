return {
	"RedsXDD/neopywal.nvim",
	branch = "testing",
	name = "neopywal",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		if vim.env.DISPLAY ~= nil then
			vim.cmd.colorscheme("neopywal")
		else
			vim.cmd([[set notermguicolors]])
			vim.cmd.colorscheme("default")
		end
	end,
}

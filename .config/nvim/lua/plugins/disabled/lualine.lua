-- vim:fileencoding=utf-8:foldmethod=marker

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		options = {
			theme = "pywal-nvim",
			icons_enabled = true,
			section_separators = "",
			-- section_separators = { left = "", right = "" },
			component_separators = "|",
			-- component_separators = { left = '', right = '' },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = {
			"lazy",
			"man",
			"mason",
			"neo-tree",
		},
	},
	config = function(_, opts)
		vim.opt.laststatus = 3
		require("lualine").setup(opts)
	end,
}

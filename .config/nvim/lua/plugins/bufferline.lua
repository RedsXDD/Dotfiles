return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	version = "*",
	event = { "BufReadPost", "BufNewFile", "BufUnload" },
	opts = function()
		return {
			highlights = require("neopywal.bufferline").setup(),
			options = {
				numbers = "ordinal",
				buffer_close_icon = "",
				close_icon = "",
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				diagnostics = "nvim_lsp",
				separator_style = "slope", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
				offsets = {
					{
						highlight = "BufferLineFill",
						filetype = "neo-tree",
						text = "Neo-tree",
						text_align = "center",
					},
				},
			},
		}
	end,
}

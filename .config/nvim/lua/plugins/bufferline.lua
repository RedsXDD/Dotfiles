return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	version = "*",
	event = { "BufReadPost", "BufNewFile", "BufUnload" },
	opts = function()
		return {
			highlights = require("neopywal.bufferline").setup(),
			options = {
				mode = "buffers",
				numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
				buffer_close_icon = "",
				close_icon = "",
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				-- max_name_length = 20,
				max_prefix_length = 15,
				truncate_names = false,
				tab_size = 10,
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
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

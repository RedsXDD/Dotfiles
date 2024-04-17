return {
	"echasnovski/mini.indentscope",
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"starter",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
	opts = {
		draw = { animation = function() return 1 end },
		options = { try_as_border = true },
		symbol = "▏",
		-- symbol = "│",
		-- symbol = "┊",
	},
}

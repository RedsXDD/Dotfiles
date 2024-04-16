return {
	"echasnovski/mini.indentscope",
	event = { "BufRead", "BufNewFile" },
	opts = {
		draw = {
			animation = function()
				return 1
			end,
		},
		-- symbol = "│",
		symbol = "┊",
	},
}

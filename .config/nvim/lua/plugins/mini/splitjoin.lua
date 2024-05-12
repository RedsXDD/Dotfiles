return {
	"echasnovski/mini.splitjoin",
	keys = {
		{ "gS", desc = "Toggle splitjoining." },
	},
	config = function()
		local splitjoin = require("mini.splitjoin")
		splitjoin.setup({
			detect = { separator = "[,;]" },
			mappings = {
				toggle = "gS",
				split = "",
				join = "",
			},
		})
	end,
}

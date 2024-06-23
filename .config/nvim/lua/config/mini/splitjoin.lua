local splitjoin = require("mini.splitjoin")

splitjoin.setup({
	detect = { separator = "[,;]" },
	mappings = {
		toggle = "gS",
		split = "",
		join = "",
	},
})

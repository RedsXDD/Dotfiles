local splitjoin = require("mini.splitjoin")

splitjoin.setup({
	detect = { separator = "[,;]" },
	mappings = {
		toggle = "<Leader>jt",
		split = "<Leader>js",
		join = "<Leader>jj",
	},
})

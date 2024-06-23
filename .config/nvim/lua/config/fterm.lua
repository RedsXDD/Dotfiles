local fterm = require("FTerm")

fterm.setup({
	ft = "FTerm",
	border = require("core.icons").misc.border,
	auto_close = true,
	hl = "NormalFloat",
	blend = 0,
	dimensions = {
		height = 0.9, -- Height of the terminal window
		width = 0.9, -- Width of the terminal window
		x = 0.5, -- X axis of the terminal window
		y = 0.5, -- Y axis of the terminal window
	},
})

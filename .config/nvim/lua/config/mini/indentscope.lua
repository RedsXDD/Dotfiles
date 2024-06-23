local indentscope = require("mini.indentscope")

indentscope.setup({
	draw = {
		animation = function()
			return 1
		end,
	},
	options = { try_as_border = true },
	symbol = require("core.icons").misc.indent,
})

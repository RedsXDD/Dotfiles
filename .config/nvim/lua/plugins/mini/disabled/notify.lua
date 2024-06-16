return {
	"echasnovski/mini.notify",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		lsp_progress = { enable = true },
		window = { config = { border = require("user.icons").misc.border } },
	},
}

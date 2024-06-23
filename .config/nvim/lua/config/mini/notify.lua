local notify = require("mini.notify")

notify.setup({
	lsp_progress = { enable = true },
	window = { config = { border = require("user.icons").misc.border } },
})

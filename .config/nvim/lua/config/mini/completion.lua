local completion = require("mini.completion")
completion.setup({
	set_vim_settings = true,
	delay = { completion = 100, info = 100, signature = 50 },

	-- Configuration for actions window:
	window = {
		info = { height = 25, width = 80, border = require("user.icons").misc.border },
		signature = { height = 25, width = 80, border = require("user.icons").misc.border },
	},

	lsp_completion = {
		source_func = "omnifunc", -- Should be one of 'completefunc' or 'omnifunc'.
	},

	mappings = {
		force_twostep = "<C-Space>", -- Force two-step completion
		force_fallback = "<A-Space>", -- Force fallback completion
	},
})

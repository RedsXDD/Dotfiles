return {
	"echasnovski/mini.completion",
	event = "InsertEnter",
	opts = {
		set_vim_settings = true,
		delay = { completion = 100, info = 100, signature = 50 },

		-- Configuration for actions window:
		window = {
			info = { height = 25, width = 80, border = "rounded" },
			signature = { height = 25, width = 80, border = "rounded" },
		},

		lsp_completion = {
			source_func = "completefunc", -- Should be one of 'completefunc' or 'omnifunc'.
		},

		mappings = {
			force_twostep = "<C-Space>", -- Force two-step completion
			force_fallback = "<A-Space>", -- Force fallback completion
		},
	},
}

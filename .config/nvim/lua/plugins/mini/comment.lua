return {
	"echasnovski/mini.comment",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		{ "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
	},
	keys = {
		{ "gc", mode = { "n", "x" }, desc = "Comment" },
	},
	opts = {
		options = {
			ignore_blank_line = true,
			custom_commentstring = function()
				return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	},
}

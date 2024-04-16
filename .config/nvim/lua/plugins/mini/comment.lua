return {
	"echasnovski/mini.comment",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		{ "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
	},
	--stylua: ignore start
	keys = { { "gc", mode = { "n", "x" }, desc = "Comment" }, },
	--stylua: ignore end
	opts = {
		options = {
			ignore_blank_line = true,
			custom_commentstring = function()
				return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	},
}

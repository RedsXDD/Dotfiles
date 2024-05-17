return {
	"echasnovski/mini.comment",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		{ "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
	},
	keys = {
		{ "<Leader>c", mode = { "n", "x" }, desc = "+Comment" },
	},
	opts = {
		mappings = {
			comment = '<Leader>c',        -- Toggle comment on Normal and Visual modes.
			comment_visual = '<Leader>c', -- Toggle comment on visual selection.
			comment_line = '<Leader>cc',  -- Toggle comment on current line.
			textobject = '<Leader>c', -- Define 'comment' textobject (like `d<Leader>c` - delete whole comment block). Works also in Visual mode if mapping differs from `comment_visual`.
		},
		options = {
			ignore_blank_line = true,
			custom_commentstring = function()
				return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	},
}

local comment = require("mini.comment")

comment.setup({
	options = {
		ignore_blank_line = true,
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})

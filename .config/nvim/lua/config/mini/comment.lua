local has_comment, comment = pcall(require, "mini.comment")
if not has_comment then
	return
end

comment.setup({
	options = {
		ignore_blank_line = true,
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})

local has_aerial, aerial = pcall(require, "aerial")
if not has_aerial then
	return
end

local icons = require("core.icons")
aerial.setup({
	attach_mode = "global",
	backends = { "lsp", "treesitter", "markdown", "man" },
	show_guides = true,
	layout = {
		resize_to_content = false,
		win_opts = {
			winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
			signcolumn = "yes",
			statuscolumn = " ",
		},
	},
	icons = icons.kinds,
	-- filter_kind = filter_kind,
	guides = {
		mid_item = icons.aerial.mid_item,
		last_item = icons.aerial.last_item,
		nested_top = icons.aerial.nested_top,
		whitespace = "  ",
	},
})

local has_ibl, ibl = pcall(require, "ibl")
if not has_ibl then
	return
end

ibl.setup({
	indent = {
		char = require("core.icons").misc.indent,
		tab_char = require("core.icons").misc.indent,
	},
	scope = { show_start = false, show_end = false },
	exclude = {
		filetypes = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		},
	},
})

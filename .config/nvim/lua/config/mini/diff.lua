local has_diff, diff = pcall(require, "mini.diff")
if not has_diff then
	return
end

local icons = require("core.icons").gitsigns

vim.keymap.set("n", "<Leader>do", function()
	require("mini.diff").toggle_overlay(0)
end, { noremap = true, desc = "Toggle mini.diff overlay." })

diff.setup({
	view = {
		style = "sign",
		signs = {
			add = icons.add,
			change = icons.change,
			delete = icons.delete,
		},
		priority = vim.highlight.priorities.user - 1, -- Priority of used visualization extmarks.
	},
	mappings = {
		textobject = "<Leader>dh", -- Hunk range textobject to be used inside operator.
		apply = "<Leader>dh", -- Apply hunks inside a visual/operator region.
		reset = "<Leader>dH", -- Reset hunks inside a visual/operator region.
	},
})

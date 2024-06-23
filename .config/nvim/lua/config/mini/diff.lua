local diff = require("mini.diff")
local icons = require("core.icons").gitsigns

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

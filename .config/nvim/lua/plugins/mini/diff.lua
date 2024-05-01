return {
	"echasnovski/mini.diff",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "[h", "]h", "[H", "]H" },
		{ "<Leader>d" },
		{ "<Leader>do", function() require("mini.diff").toggle_overlay(0) end, desc = "Toggle mini.diff overlay." },
	},
	opts = {
		delay = { text_change = 200 }, -- How much to wait before update following every text change.
		view = {
			-- Default: 'number' if line numbers are enabled, 'sign' otherwise.
			style = vim.go.number and "number" or "sign",
			signs = {
				add = require("user.icons").icons.gitsigns.add,
				change = require("user.icons").icons.gitsigns.change,
				delete = require("user.icons").icons.gitsigns.delete,
			},
			priority = vim.highlight.priorities.user - 1, -- Priority of used visualization extmarks.
		},
		mappings = {
			textobject = "<Leader>dh", -- Hunk range textobject to be used inside operator.
			apply = "<Leader>dh", -- Apply hunks inside a visual/operator region.
			reset = "<Leader>dH", -- Reset hunks inside a visual/operator region.

			-- Go to hunk range in corresponding direction.
			goto_first = "[H",
			goto_prev = "[h",
			goto_next = "]h",
			goto_last = "]H",
		},
		options = {
			algorithm = "histogram",
			indent_heuristic = true,
			linematch = 60,
			wrap_goto = false,
		},
	},
}

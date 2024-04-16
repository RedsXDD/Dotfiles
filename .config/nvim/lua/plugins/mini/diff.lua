return {
	"echasnovski/mini.diff",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "gh", "gH", "[h", "]h", "[H", "]H" },
		{ "<leader>go", function() require("mini.diff").toggle_overlay(0) end, desc = "Toggle mini.diff overlay." },
	},
	opts = {
		delay = { text_change = 200, }, -- How much to wait before update following every text change.
		view = {
			-- Default: 'number' if line numbers are enabled, 'sign' otherwise.
			style = vim.go.number and 'number' or 'sign',
			signs = {
				-- add = "▎",
				-- change = "▎",
				-- delete = "",

				add = "+",
				change = "~",
				delete = "-",
			},
			priority = vim.highlight.priorities.user - 1, -- Priority of used visualization extmarks.
		},
		mappings = {
			apply = 'gh', -- Apply hunks inside a visual/operator region.
			reset = 'gH', -- Reset hunks inside a visual/operator region.
			textobject = 'gh', -- Hunk range textobject to be used inside operator.

			-- Go to hunk range in corresponding direction.
			goto_first = '[H',
			goto_prev = '[h',
			goto_next = ']h',
			goto_last = ']H',
		},
		options = {
			algorithm = 'histogram',
			indent_heuristic = true,
			linematch = 60,
			wrap_goto = false,
		},
	},
}

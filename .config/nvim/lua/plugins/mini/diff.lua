return {
	"echasnovski/mini.diff",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"<leader>go",
			function()
				require("mini.diff").toggle_overlay(0)
			end,
			desc = "Toggle mini.diff overlay.",
		},
	},
	opts = {
		view = {
			style = "sign",
			signs = {
				-- add = "▎",
				-- change = "▎",
				-- delete = "",

				add = "+",
				change = ">",
				delete = "-",
			},
		},
	},
}

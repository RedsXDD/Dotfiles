return {
	"echasnovski/mini.splitjoin",
	keys = { { "gS", desc = "Toggle splitjoining." } },
	config = function()
		local splitjoin = require("mini.splitjoin")
		local gen_hook = splitjoin.gen_hook
		local curly = { brackets = { "%b{}" } }

		-- Add trailing comma when splitting inside curly brackets
		local add_comma_curly = gen_hook.add_trailing_separator(curly)

		-- Delete trailing comma when joining inside curly brackets
		local del_comma_curly = gen_hook.del_trailing_separator(curly)

		-- Pad curly brackets with single space after join
		local pad_curly = gen_hook.pad_brackets(curly)

		splitjoin.setup({
			detect = {
				separator = "[,;]",
			},
			mappings = {
				toggle = "gS",
				split = "",
				join = "",
			},
			split = {
				hooks_pre = {},
				hooks_post = { add_comma_curly },
			},
			join = {
				hooks_pre = {},
				hooks_post = { del_comma_curly, pad_curly },
			},
		})
	end,
}

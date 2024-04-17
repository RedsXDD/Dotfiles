return {
	"echasnovski/mini.pairs",
	--stylua: ignore start
	keys = {
		{ "'", mode = { "i" } }, { '"', mode = { "i" } }, { "`", mode = { "i" } },
		{ "(", mode = { "i" } }, { ")", mode = { "i" } },
		{ "[", mode = { "i" } }, { "]", mode = { "i" } },
		{ "{", mode = { "i" } }, { "}", mode = { "i" } },
		{ "<", mode = { "i" } }, { ">", mode = { "i" } },
		{ "<Leader>tp", function() vim.g.minipairs_disable = not vim.g.minipairs_disable end, mode = { "n", "x" }, desc = "Toggle Mini.pairs." },
	},
	--stylua: ignore end
	opts = {
		modes = { insert = true, command = true, terminal = false },

		-- Global mappings. Each right hand side should be a pair information, a
		-- table with at least these fields (see more in |MiniPairs.map|):
		-- - <action> - one of 'open', 'close', 'closeopen'.
		-- - <pair> - two character string for pair to be used.
		-- By default pair is not inserted after `\`, quotes are not recognized by
		-- `<CR>`, `'` does not insert pair after a letter.
		-- Only parts of tables can be tweaked (others will use these defaults).
		mappings = {
			["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
			["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
			["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
			["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\].", register = { cr = false } },

			[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
			["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
			["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
			[">"] = { action = "close", pair = "<>", register = { cr = false } },

			['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
			["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
			["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
		},
	},
}

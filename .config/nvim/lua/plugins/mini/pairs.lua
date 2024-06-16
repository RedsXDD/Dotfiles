return {
	"echasnovski/mini.pairs",
	event = "CmdlineEnter",
	keys = function()
		local M = {}

		local lazy_load_keys = { "'", '"', "`", "´", "(", ")", "[", "]", "{", "}", "<", ">" }
		for _, key in ipairs(lazy_load_keys) do
			table.insert(M, { key, mode = { "i" } })
		end

		local pairs_map = function(modes, keys, func, desc)
			local keymap_table = { keys, func, mode = modes, noremap = true, desc = "" .. desc }
			table.insert(M, keymap_table)
		end

		pairs_map({ "n", "x" }, "<Leader>tp", function()
			local state = vim.g.minipairs_disable
			state = not state
			vim.g.minipairs_disable = state
			vim.notify(state and "Enabled " .. "mini.pairs" or "Disabled " .. "mini.pairs", vim.log.levels.INFO)
		end, "Toggle Mini.pairs.")

		return M
	end,
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
			[">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\].", register = { cr = false } },

			['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
			["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
			["´"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\´].", register = { cr = false } },
			["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
		},
	},
}

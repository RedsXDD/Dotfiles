return {
	"echasnovski/mini.clue",
	dependencies = {
		{ "echasnovski/mini.bracketed", opts = {} }, -- NOTE: Setting `mini.bracketed` as a dependency is needed to load it's clues correctly.
	},
	keys = {
		-- stylua: ignore start
		{ "<C-r>",    mode = { "i", "c" } },
		{ "<C-x>",    mode = { "i" } },
		{ "<C-w>",    mode = { "n" } },
		{ "<Leader>", mode = { "n", "x" } },
		{ "g",        mode = { "n", "x" } },
		{ "'",        mode = { "n", "x" } },
		{ "`",        mode = { "n", "x" } },
		{ '"',        mode = { "n", "x" } },
		{ "z",        mode = { "n", "x" } },
		{ "[",        mode = { "n", "x" } },
		{ "]",        mode = { "n", "x" } },
		-- stylua: ignore end
	},
	config = function()
		local clue = require("mini.clue")
		local border_style = require("user.icons").icons.misc.border

		clue.mkclue_with_dependency = function(dependency, clues)
			if dependency and type(dependency) == "string" then
				local success, _ = pcall(require, dependency)
				if not success then
					return false
				else
					return { clues }
				end
			end
		end

		clue.setup({
			window = {
				delay = 0, -- Delay in ms.
				scroll_up = "<C-k>",
				scroll_down = "<C-j>",
				config = {
					width = "auto",
					border = border_style,
				},
			},
			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },
				{ mode = "i", keys = "<C-x>" },
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },
				{ mode = "n", keys = "<C-w>" },
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
				{ mode = "n", keys = "[" },
				{ mode = "n", keys = "]" },
				{ mode = "x", keys = "[" },
				{ mode = "x", keys = "]" },
			},
			clues = {
				-- General:
				{ mode = "n", keys = "<Leader>b", desc = "Buffers & Tabs" },
				{ mode = "x", keys = "<Leader>b", desc = "Buffers & Tabs" },
				{ mode = "n", keys = "<Leader>t", desc = "Toggles" },
				{ mode = "x", keys = "<Leader>t", desc = "Toggles" },
				{ mode = "n", keys = "<Leader>g", desc = "Misc" },
				{ mode = "x", keys = "<Leader>g", desc = "Misc" },

				-- Noice:
				clue.mkclue_with_dependency("noice", { mode = "n", keys = "<Leader>gn", desc = "Noice" }),

				-- Lsp:
				clue.mkclue_with_dependency("lspconfig", {
					{ mode = "n", keys = "<Leader>l", desc = "LSP" },
					{ mode = "n", keys = "]d", postkeys = "]" },
					{ mode = "n", keys = "]D", postkeys = "]" },
					{ mode = "n", keys = "[d", postkeys = "[" },
					{ mode = "n", keys = "[D", postkeys = "[" },
					{ mode = "x", keys = "]d", postkeys = "]" },
					{ mode = "x", keys = "]D", postkeys = "]" },
					{ mode = "x", keys = "[d", postkeys = "[" },
					{ mode = "x", keys = "[D", postkeys = "[" },
				}),

				-- Mini.map:
				clue.mkclue_with_dependency("mini.map", { mode = "n", keys = "<Leader>m", desc = "MiniMap" }),

				-- Mini.surround:
				clue.mkclue_with_dependency("mini.surround", {
					{ mode = "n", keys = "<Leader>s", desc = "Surround" },
					{ mode = "x", keys = "<Leader>s", desc = "Surround" },
				}),

				-- Mini.diff:
				clue.mkclue_with_dependency("mini.diff", {
					{ mode = "n", keys = "<Leader>d", desc = "MiniDiff" },
					{ mode = "n", keys = "]h", postkeys = "]" },
					{ mode = "n", keys = "]H", postkeys = "]" },
					{ mode = "n", keys = "[h", postkeys = "[" },
					{ mode = "n", keys = "[H", postkeys = "[" },
					{ mode = "x", keys = "]h", postkeys = "]" },
					{ mode = "x", keys = "]H", postkeys = "]" },
					{ mode = "x", keys = "[h", postkeys = "[" },
					{ mode = "x", keys = "[H", postkeys = "[" },
				}),

				-- Gitsigns:
				clue.mkclue_with_dependency("gitsigns", {
					{ mode = "n", keys = "<Leader>gh", desc = "Gitsigns" },
					{ mode = "x", keys = "<Leader>gh", desc = "Gitsigns" },
					{ mode = "n", keys = "]h", postkeys = "]" },
					{ mode = "n", keys = "]H", postkeys = "]" },
					{ mode = "n", keys = "[h", postkeys = "[" },
					{ mode = "n", keys = "[H", postkeys = "[" },
					{ mode = "x", keys = "]h", postkeys = "]" },
					{ mode = "x", keys = "]H", postkeys = "]" },
					{ mode = "x", keys = "[h", postkeys = "[" },
					{ mode = "x", keys = "[H", postkeys = "[" },
				}),

				-- Jump betwheen brackets.
				{ mode = "n", keys = "])", desc = "Jump to next `)`" },
				{ mode = "n", keys = "]]", desc = "Jump to next `]`" },
				{ mode = "n", keys = "]}", desc = "Jump to next `}`" },
				{ mode = "n", keys = "[(", desc = "Jump to previous `(`" },
				{ mode = "n", keys = "[[", desc = "Jump to previous `[`" },
				{ mode = "n", keys = "[{", desc = "Jump to previous `{`" },
				{ mode = "x", keys = "])", desc = "Jump to next `)`" },
				{ mode = "x", keys = "]]", desc = "Jump to next `]`" },
				{ mode = "x", keys = "]}", desc = "Jump to next `}`" },
				{ mode = "x", keys = "[(", desc = "Jump to previous `(`" },
				{ mode = "x", keys = "[[", desc = "Jump to previous `[`" },
				{ mode = "x", keys = "[{", desc = "Jump to previous `{`" },

				-- Mini.bracketed:
				clue.mkclue_with_dependency("mini.bracketed", {
					-- Jump betwheen buffers.
					{ mode = "n", keys = "]b", postkeys = "]" },
					{ mode = "n", keys = "]B", postkeys = "]" },
					{ mode = "n", keys = "[b", postkeys = "[" },
					{ mode = "n", keys = "[B", postkeys = "[" },

					-- Jump betwheen comments.
					{ mode = "n", keys = "]c", postkeys = "]" },
					{ mode = "n", keys = "]C", postkeys = "]" },
					{ mode = "n", keys = "[c", postkeys = "[" },
					{ mode = "n", keys = "[C", postkeys = "[" },
					{ mode = "x", keys = "]c", postkeys = "]" },
					{ mode = "x", keys = "]C", postkeys = "]" },
					{ mode = "x", keys = "[c", postkeys = "[" },
					{ mode = "x", keys = "[C", postkeys = "[" },

					-- Jump betwheen conflicts.
					{ mode = "n", keys = "]x", postkeys = "]" },
					{ mode = "n", keys = "]X", postkeys = "]" },
					{ mode = "n", keys = "[x", postkeys = "[" },
					{ mode = "n", keys = "[X", postkeys = "[" },
					{ mode = "x", keys = "]x", postkeys = "]" },
					{ mode = "x", keys = "]X", postkeys = "]" },
					{ mode = "x", keys = "[x", postkeys = "[" },
					{ mode = "x", keys = "[X", postkeys = "[" },

					-- Jump betwheen files.
					{ mode = "n", keys = "]f", postkeys = "]" },
					{ mode = "n", keys = "]F", postkeys = "]" },
					{ mode = "n", keys = "[f", postkeys = "[" },
					{ mode = "n", keys = "[F", postkeys = "[" },

					-- Jump betwheen indentation.
					{ mode = "n", keys = "]i", postkeys = "]" },
					{ mode = "n", keys = "]I", postkeys = "]" },
					{ mode = "n", keys = "[i", postkeys = "[" },
					{ mode = "n", keys = "[I", postkeys = "[" },
					{ mode = "x", keys = "]i", postkeys = "]" },
					{ mode = "x", keys = "]I", postkeys = "]" },
					{ mode = "x", keys = "[i", postkeys = "[" },
					{ mode = "x", keys = "[I", postkeys = "[" },

					-- Jump betwheen jumps from jump-list.
					{ mode = "n", keys = "]j", postkeys = "]" },
					{ mode = "n", keys = "]J", postkeys = "]" },
					{ mode = "n", keys = "[j", postkeys = "[" },
					{ mode = "n", keys = "[J", postkeys = "[" },

					-- Jump betwheen locations from location-list.
					{ mode = "n", keys = "]l", postkeys = "]" },
					{ mode = "n", keys = "]L", postkeys = "]" },
					{ mode = "n", keys = "[l", postkeys = "[" },
					{ mode = "n", keys = "[L", postkeys = "[" },

					-- Jump betwheen old files.
					{ mode = "n", keys = "]o", postkeys = "]" },
					{ mode = "n", keys = "]O", postkeys = "]" },
					{ mode = "n", keys = "[o", postkeys = "[" },
					{ mode = "n", keys = "[O", postkeys = "[" },

					-- Jump betwheen quickfixes from quickfix-list.
					{ mode = "n", keys = "]q", postkeys = "]" },
					{ mode = "n", keys = "]Q", postkeys = "]" },
					{ mode = "n", keys = "[q", postkeys = "[" },
					{ mode = "n", keys = "[Q", postkeys = "[" },

					-- Jump betwheen tree-sitter node and parents.
					{ mode = "n", keys = "]t", postkeys = "]" },
					{ mode = "n", keys = "]T", postkeys = "]" },
					{ mode = "n", keys = "[t", postkeys = "[" },
					{ mode = "n", keys = "[T", postkeys = "[" },
					{ mode = "x", keys = "]t", postkeys = "]" },
					{ mode = "x", keys = "]T", postkeys = "]" },
					{ mode = "x", keys = "[t", postkeys = "[" },
					{ mode = "x", keys = "[T", postkeys = "[" },

					-- Jump betwheen undo states.
					{ mode = "n", keys = "]u", postkeys = "]" },
					{ mode = "n", keys = "]U", postkeys = "]" },
					{ mode = "n", keys = "[u", postkeys = "[" },
					{ mode = "n", keys = "[U", postkeys = "[" },

					-- Jump betwheen windows.
					{ mode = "n", keys = "]w", postkeys = "]" },
					{ mode = "n", keys = "]W", postkeys = "]" },
					{ mode = "n", keys = "[w", postkeys = "[" },
					{ mode = "n", keys = "[W", postkeys = "[" },

					-- Jump betwheen yank selection replacing latest put region.
					{ mode = "n", keys = "]y", postkeys = "]" },
					{ mode = "n", keys = "]Y", postkeys = "]" },
					{ mode = "n", keys = "[y", postkeys = "[" },
					{ mode = "n", keys = "[Y", postkeys = "[" },
				}),

				-- Mini.pick:
				clue.mkclue_with_dependency("mini.pick", {
					{ mode = "n", keys = "<Leader>f", desc = "MiniPick" },
					{ mode = "n", keys = "<Leader>fg", desc = "Grep" },
					{ mode = "n", keys = "<Leader>fG", desc = "Git" },
					{ mode = "n", keys = "<Leader>fl", desc = "LSP" },
					{ mode = "n", keys = "<Leader>fL", desc = "List" },
				}),

				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.z(),
				clue.gen_clues.windows({
					submode_move = true,
					submode_navigate = true,
					submode_resize = true,
				}),
			},
		})
	end,
}

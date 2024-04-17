return {
	"echasnovski/mini.clue",
	-- NOTE: Setting mini.bracketed as a dependency allows mini.clue to
	-- always load bracketed's clues even when a non bracket key triggers the lazy loading of mini.clue.
	dependencies = { { "echasnovski/mini.bracketed", opts = {} } },
	--stylua: ignore start
	keys = {
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
	},
	--stylua: ignore end
	config = function()
		local clue = require("mini.clue")

		clue.requires_clue = function(required, clues)
			if required and type(required) == "string" then
				local success, _ = pcall(require, required)
				if not success then
					return false
				else
					return { clues }
				end
			end
		end

		clue.setup({
			window = {
				delay = 300, -- Delay in ms.
				scroll_up = "<C-k>",
				scroll_down = "<C-j>",
				config = {
					width = "auto",
					border = "rounded",
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
				{ mode = "n", keys = "<Leader>b", desc = "+Buffers & Tabs" },
				{ mode = "x", keys = "<Leader>b", desc = "+Buffers & Tabs" },
				{ mode = "n", keys = "<Leader>t", desc = "+Toggles" },
				{ mode = "x", keys = "<Leader>t", desc = "+Toggles" },
				{ mode = "n", keys = "<Leader>g", desc = "+Misc" },
				{ mode = "x", keys = "<Leader>g", desc = "+Misc" },

				-- Lsp:
				clue.requires_clue("lspconfig", { mode = "n", keys = "<Leader>l", desc = "+LSP" }),

				-- Noice:
				clue.requires_clue("noice", { mode = "n", keys = "<Leader>gn", desc = "+Noice" }),

				-- Mini.map:
				clue.requires_clue("mini.map", { mode = "n", keys = "<Leader>m", desc = "+MiniMap" }),

				-- Mini.surround:
				clue.requires_clue("mini.surround", {
					{ mode = "n", keys = "<Leader>s", desc = "+Surround" },
					{ mode = "x", keys = "<Leader>s", desc = "+Surround" },
				}),

				-- Gitsigns:
				clue.requires_clue("gitsigns", {
					{ mode = "n", keys = "<Leader>gh", desc = "+Gitsigns" },
					{ mode = "x", keys = "<Leader>gh", desc = "+Gitsigns" },
				}),

				-- Mini.bracketed:
				clue.requires_clue("mini.bracketed", {
					{ mode = "n", keys = "]b", postkeys = "]" },
					{ mode = "n", keys = "]w", postkeys = "]" },
					{ mode = "n", keys = "[b", postkeys = "[" },
					{ mode = "n", keys = "[w", postkeys = "[" },
				}),

				-- Mini.pick:
				clue.requires_clue("mini.pick", {
					{ mode = "n", keys = "<Leader>f", desc = "+MiniPick" },
					{ mode = "n", keys = "<Leader>fg", desc = "+Grep" },
					{ mode = "n", keys = "<Leader>fG", desc = "+Git" },
					{ mode = "n", keys = "<Leader>fl", desc = "+LSP" },
					{ mode = "n", keys = "<Leader>fL", desc = "+List" }
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

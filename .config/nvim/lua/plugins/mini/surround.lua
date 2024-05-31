return {
	"echasnovski/mini.surround",
	keys = {
		{ "<Leader>sa", mode = { "n", "v" }, desc = "Add Surrounding." },
		{ "<Leader>sd", desc = "Delete Surrounding." },
		{ "<Leader>sr", desc = "Replace Surrounding." },
		{ "<Leader>sf", desc = "Find Right Surrounding." },
		{ "<Leader>sF", desc = "Find Left Surrounding." },
		{ "<Leader>sh", desc = "Highlight Surrounding." },
		{ "<Leader>sn", desc = "Update `MiniSurround.config.n_lines`." },
	},
	opts = {
		respect_selection_type = true,
		mappings = {
			add = "<Leader>sa", -- Add surrounding in Normal and Visual modes.
			delete = "<Leader>sd", -- Delete surrounding.
			find = "<Leader>sf", -- Find surrounding (to the right).
			find_left = "<Leader>sF", -- Find surrounding (to the left).
			highlight = "<Leader>sh", -- Highlight surrounding.
			replace = "<Leader>sr", -- Replace surrounding.
			update_n_lines = "<Leader>sn", -- Update `n_lines`.
		},
	},
}

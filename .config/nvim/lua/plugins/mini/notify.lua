return {
	"echasnovski/mini.notify",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		lsp_progress = { enable = false },
		window = { config = { border = "rounded" } },
	},
}

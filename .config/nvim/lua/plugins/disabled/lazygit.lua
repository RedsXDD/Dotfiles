return {
	"kdheepak/lazygit.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	keys = {
		{ "<Leader>gg", "<CMD>LazyGit<CR>", desc = "Open LazyGit." },
	}
}

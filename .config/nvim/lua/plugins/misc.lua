return {
	{
		"theRealCarneiro/hyprland-vim-syntax",
		ft = "hypr",
	},
	-- {
	-- 	"camnw/lf-vim",
	-- 	ft = "lf",
	-- },
	-- {
	-- 	"fladson/vim-kitty",
	-- 	ft = "kitty",
	-- },
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
}

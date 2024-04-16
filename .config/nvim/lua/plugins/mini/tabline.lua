return {
	"echasnovski/mini.tabline",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		show_icons = true,
		set_vim_settings = true, -- Whether to set Vim's settings for tabline (make it always shown and allow hidden buffers).
		tabpage_section = "right", -- Where to show tabpage section in case of multiple vim tabpages.
	},
}

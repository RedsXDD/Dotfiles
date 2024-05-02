return {
	"echasnovski/mini.tabline",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile", "BufUnload" },
	opts = function()
		local show_icons = true
		if vim.env.DISPLAY == nil then
			show_icons = false
		end

		return {
			show_icons = show_icons,
			set_vim_settings = true, -- Whether to set Vim's settings for tabline (make it always shown and allow hidden buffers).
			tabpage_section = "right", -- Where to show tabpage section in case of multiple vim tabpages.
		}
	end,
}

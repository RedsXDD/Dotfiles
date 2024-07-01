local has_tabline, tabline = pcall(require, "mini.tabline")
if not has_tabline then
	return
end

local show_icons = true
if vim.env.DISPLAY == nil then
	show_icons = false
end

tabline.setup({
	show_icons = show_icons,
	set_vim_settings = true, -- Whether to set Vim's settings for tabline (make it always shown and allow hidden buffers).
	tabpage_section = "right", -- Where to show tabpage section in case of multiple vim tabpages.
})

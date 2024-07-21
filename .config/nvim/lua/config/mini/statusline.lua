local has_statusline, statusline = pcall(require, "mini.statusline")
if not has_statusline then
	return
end

statusline.setup()

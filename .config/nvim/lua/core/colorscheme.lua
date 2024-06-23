---@diagnostic disable: param-type-mismatch
local colorscheme = "neopywal"
local has_colorscheme, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not has_colorscheme then
	vim.notify("Could not load colorscheme '" .. colorscheme .. "'!")
	vim.cmd.colorscheme("sorbet")
	return
end

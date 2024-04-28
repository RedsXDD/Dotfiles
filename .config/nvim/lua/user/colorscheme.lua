if vim.env.DISPLAY ~= nil then
	vim.cmd.colorscheme("pywal")
else
	vim.cmd([[set notermguicolors]])
	vim.cmd.colorscheme("default")
end

local fterm = require("FTerm")

-- stylua: ignore
vim.keymap.set("n", "<Leader>gt", function() fterm.toggle() end, { noremap = true, desc = "Open a floating terminal." })
vim.keymap.set("n", "<Leader>gg", function()
	local use_lazygit = true
	local git_integration = fterm:new({
		ft = use_lazygit and "fterm_lazygit" or "fterm_gitui",
		cmd = use_lazygit and "lazygit" or { "gg", "-d", vim.api.nvim_buf_get_name(0) }, -- Uses custom gitui script that fixes ssh.
		blend = 0,
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	})
	git_integration:toggle()
end, { noremap = true, desc = "Open git integration." })

fterm.setup({
	ft = "FTerm",
	border = require("core.icons").misc.border,
	auto_close = true,
	hl = "NormalFloat",
	blend = 0,
	dimensions = {
		height = 0.9, -- Height of the terminal window
		width = 0.9, -- Width of the terminal window
		x = 0.5, -- X axis of the terminal window
		y = 0.5, -- Y axis of the terminal window
	},
})

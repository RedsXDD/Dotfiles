return {
	"numToStr/FTerm.nvim",
	keys = function()
		local M = {}
		local fterm = require("FTerm")

		local term_map = function(keys, func, desc)
			local keymap_table = { keys, func, mode = { "n" }, noremap = true, desc = "" .. desc }
			table.insert(M, keymap_table)
		end

		term_map("<Leader>gt", function()
			fterm.toggle()
		end, "Open a floating terminal.")

		term_map("<Leader>gg", function()
			local gitui = fterm:new({
				ft = "fterm_gitui", -- You can also override the default filetype, if you want
				cmd = { "gg", "-d", vim.api.nvim_buf_get_name(0) }, -- Uses custom gitui script that fixes ssh.
				blend = 0,
				dimensions = {
					height = 0.9,
					width = 0.9,
				},
			})
			gitui:toggle()
		end, "Open Gitui.")

		return M
	end,
	opts = {
		ft = "FTerm",
		border = require("user.icons").icons.misc.border,
		auto_close = true,
		hl = "NormalFloat",
		blend = 0,
		dimensions = {
			height = 0.9, -- Height of the terminal window
			width = 0.9, -- Width of the terminal window
			x = 0.5, -- X axis of the terminal window
			y = 0.5, -- Y axis of the terminal window
		},
	},
}

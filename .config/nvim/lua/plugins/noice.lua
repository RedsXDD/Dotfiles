return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		keys = function()
			local M = {}

			local noice = require("noice")
			local noice_lsp = require("noice.lsp")

			local noice_map = function(mode, keys, func, desc)
				local keymap_table = { keys, func, mode = { mode }, noremap = true, desc = "" .. desc }
				table.insert(M, keymap_table)
			end

			local noice_lsp_map = function(keys, func, desc)
				local keymap_table = {
					keys,
					func,
					mode = { "i", "n", "s" },
					noremap = true,
					silent = true,
					expr = true,
					desc = "" .. desc,
				}
				table.insert(M, keymap_table)
			end

			noice_map("c", "<S-Enter>", function()
				noice.redirect(vim.fn.getcmdline())
			end, "Redirect Cmdline")

			noice_map("n", "<Leader>gnl", function()
				noice.cmd("last")
			end, "Noice Last Message")

			noice_map("n", "<Leader>gnh", function()
				noice.cmd("history")
			end, "Noice History")

			noice_map("n", "<Leader>gna", function()
				noice.cmd("all")
			end, "Noice All")

			noice_map("n", "<Leader>gnd", function()
				noice.cmd("dismiss")
			end, "Dismiss All")

			noice_lsp_map("<C-f>", function()
				if not noice_lsp.scroll(4) then
					return "<C-f>"
				end
			end, "Scroll Forward")

			noice_lsp_map("<C-b>", function()
				if not noice_lsp.scroll(-4) then
					return "<C-b>"
				end
			end, "Scroll Backward")

			return M
		end,
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
				inc_rename = true,
			},
		},
	},
}

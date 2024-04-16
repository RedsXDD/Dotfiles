return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		--stylua: ignore start
		keys = function()
			local M = {}

			local noice = require("noice")
			local noice_lsp = require("noice.lsp")

			local noice_map = function(mode, keys, func, desc)
				local keymap_table = { keys, func, mode = { "n" }, noremap = true, desc = "" .. desc }
				table.insert(M, keymap_table)
			end

			local noice_lsp_map = function(keys, func, desc)
				local keymap_table = { keys, func, mode = { "i", "n", "s" }, noremap = true, silent = true, expr = true, desc = "" .. desc }
				table.insert(M, keymap_table)
			end

			noice_map("c", "<S-Enter>", function() noice.redirect(vim.fn.getcmdline()) end, "Redirect Cmdline")
			noice_map("n", "<Leader>gnl", function() noice.cmd("last") end, "Noice Last Message")
			noice_map("n", "<Leader>gnh", function() noice.cmd("history") end, "Noice History")
			noice_map("n", "<Leader>gna", function() noice.cmd("all") end, "Noice All")
			noice_map("n", "<Leader>gnd", function() noice.cmd("dismiss") end, "Dismiss All")

			noice_lsp_map("<C-f>", function() if not noice_lsp.scroll(4) then return "<C-f>" end end, "Scroll Forward")
			noice_lsp_map("<C-b>", function() if not noice_lsp.scroll(-4) then return "<C-b>" end end, "Scroll Backward")

			return M
		end,
		--stylua: ignore end
		config = function()
			local noice = require("noice")
			noice.setup({
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
					bottom_search = false, -- Use a classic bottom cmdline for search.
					command_palette = false, -- Position the cmdline and popupmenu together.
					long_message_to_split = true, -- Long messages will be sent to a split.
					inc_rename = true, -- Enables an input dialog for inc-rename.nvim.
					lsp_doc_border = true, -- Add a border to hover docs and signature help.
				},
			})
		end,
	},
	-- {
	-- 	"nvim-telescope/telescope-ui-select.nvim",
	-- 	dependencies = {
	-- 		"folke/noice.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 		{
	-- 			"nvim-lua/plenary.nvim",
	-- 			branch = "0.1.x",
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		{ "<Leader>~", ":Telescope noice<CR>", mode = { "n" }, desc = "List noice messages." },
	-- 	},
	-- 	config = function()
	-- 		local telescope = require("telescope")
	-- 		telescope.setup({
	-- 			extensions = {
	-- 				["ui-select"] = {
	-- 					require("telescope.themes").get_dropdown({}),
	-- 				},
	-- 			},
	-- 		})
	-- 		telescope.load_extension("ui-select")
	-- 	end,
	-- },
}

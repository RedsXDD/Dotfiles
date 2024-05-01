return {
	"echasnovski/mini.indentscope",
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		local group_name = "augroup_mini_indentscope_disable"
		local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			desc = "Auto disabled mini.indentscope when opening certain filetypes.",
			group = augroup,
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"Starter",
				"starter",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
				vim.api.nvim_clear_autocmds({ group = group_name })
			end,
		})
	end,
	opts = {
		draw = { animation = function() return 1 end },
		options = { try_as_border = true },
		-- symbol = "▏",
		symbol = "│",
		-- symbol = "┊",
	},
}

-- vim:fileencoding=utf-8:foldmethod=marker

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile" },
	opts = function()
		local M = {}

		local icons = require("user.icons").icons

		M = {
			options = {
				theme = "pywal-nvim",
				icons_enabled = true,
				always_divide_middle = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			},
			extensions = {
				"lazy",
				"man",
				"mason",
				"neo-tree",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							local summary = vim.b.minidiff_summary
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							elseif summary then
								return {
									added = summary.add,
									modified = summary.change,
									removed = summary.delete,
								}
							end
						end,
					},
				},
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
					"filename"
				},
				lualine_x = {},
				lualine_y = { "filetype", "encoding", "fileformat" },
				lualine_z = {
					{ "progress", padding = { left = 1, right = 1 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
			},
		}

		-- Set separators icons that are TTY compatible.
		if vim.env.DISPLAY ~= nil then
			M.options.section_separators = { left = "", right = "" }
			-- M.options.component_separators = { left = "", right = "" },
			M.options.component_separators = "│"
		else
			M.options.section_separators = ""
			M.options.component_separators = "|"
		end

		return M
	end,
	config = function(_, opts)
		vim.opt.laststatus = 3
		require("lualine").setup(opts)
	end,
}

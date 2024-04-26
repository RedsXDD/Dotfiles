return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile", "BufUnload" },
	opts = function()
		local M = {}

		local icons = require("user.icons").icons

		M = {
			options = {
				theme = "pywal-nvim",
				icons_enabled = true,
				always_divide_middle = true,
				component_separators = "|",
				disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			},
			extensions = {
				"lazy",
				"man",
				"mason",
				"neo-tree",
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "" }, padding = { left = 0, right = 1 }, },
				},
				lualine_b = {
					"branch",
					{
						"diff",
						padding = { left = 1, right = 0 },
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
					"filename",
				},
				lualine_x = {},
				lualine_y = {
					{ "filetype", padding = { left = 0, right = 1 } },
					"encoding",
					{ "fileformat", padding = { left = 1, right = 1 } },
					{ "progress", padding = { left = 1, right = 1 } },
				},
				lualine_z = {
					{ "location", separator = { right = "" }, padding = { left = 0, right = 0 } },
				},
			},
		}

		return M
	end,
	config = function(_, opts)
		vim.opt.laststatus = 3

		-- Set separators icons that are TTY compatible.
		local options = opts.options
		local sections = opts.sections
		if vim.env.DISPLAY ~= nil then
			options.section_separators = { left = "", right = "" }
		else
			options.section_separators = ""

			local a = sections.lualine_a
			for _, comp in ipairs(a) do
				if comp[1] == "mode" then
					comp.separator = { left = "", right = "" }
					comp.padding = { left = 1, right = 1 }
					break
				end
			end

			local b = sections.lualine_b
			for _, comp in ipairs(b) do
				if comp[1] == "diff" then
					comp.padding = { left = 1, right = 1 }
					break
				end
			end

			local y = sections.lualine_y
			for _, comp in ipairs(y) do
				if comp[1] == "filetype" then
					comp.padding = { left = 1, right = 1 }
					break
				end
			end

			local z = sections.lualine_z
			for _, comp in ipairs(z) do
				if comp[1] == "location" then
					comp.separator = { left = "" }
					comp.padding = { left = 1, right = 1 }
					break
				end
			end
		end

		require("lualine").setup(opts)
	end,
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile", "BufUnload" },
	opts = function()
		local icons = require("user.icons").icons

		return {
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
					{ "filetype" },
					"filesize",
					{ "filename", padding = { left = 1, right = 0 }, },
				},
				lualine_c = {
					{ "branch" },
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
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
				},
				lualine_x = {},
				lualine_y = {
					{ "encoding", padding = { left = 0, right = 1 } },
					{ "fileformat", icons_enabled = false, padding = { left = 1, right = 1 } },
					{ "progress", padding = { left = 1, right = 1 } },
				},
				lualine_z = {
					{ "location", separator = { right = "" }, padding = { left = 1, right = 0 } },
				},
			},
		}
	end,
	config = function(_, opts)
		local lualine = require("lualine")
		local options = opts.options
		local sections = opts.sections

		-- Create a configuration that's TTY compatible.
		if vim.env.DISPLAY ~= nil then
			options.section_separators = { left = "", right = "" }
		else
			options.section_separators = ""

			-- Define a map of component names that need to be modified to their corresponding sections:
			local component_map = {
				["mode"] = sections.lualine_a,
				["filetype"] = sections.lualine_b,
				["filename"] = sections.lualine_b,
				["branch"] = sections.lualine_c,
				["encoding"] = sections.lualine_y,
				["location"] = sections.lualine_z
			}

			for comp_name, section in pairs(component_map) do
				for _, comp in ipairs(section) do
					if comp[1] == comp_name then
						if comp_name == "mode" then
							comp.separator = { left = "", right = "" }
							comp.padding = { left = 1, right = 1 }
						elseif comp_name == "filetype" or comp_name == "filename" or comp_name == "encoding" then
							comp.icons_enabled = false
							comp.padding = { left = 1, right = 1 }
						elseif comp_name == "branch" then
							comp.icons_enabled = false
						elseif comp_name == "location" then
							comp.separator = { left = "" }
							comp.padding = { left = 1, right = 1 }
						end
						break
					end
				end
			end
		end

		lualine.setup(opts)
	end,
}

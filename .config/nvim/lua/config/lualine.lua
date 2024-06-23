local icons = require("user.icons")
local lualine = require("lualine")

local location = function()
	return "ln:" .. "%l" .. " " .. "cl:" .. "%v"
end

local opts = {
	options = {
		theme = "auto",
		icons_enabled = true,
		always_divide_middle = true,
		component_separators = "|",
		disabled_filetypes = {
			statusline = {
				"dashboard",
				"alpha",
				"starter",
			},
		},
	},
	extensions = {
		"lazy",
		"man",
		"mason",
		"neo-tree",
	},
}

local global_sections = {
	sections = {
		lualine_b = {
			"filetype",
			"filesize",
			"filename",
		},
		lualine_c = {
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
	},
}

local theme = {
	options = {
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "", right = "" }, padding = { left = 0, right = 0 } },
		},
		lualine_y = {
			"encoding",
			{ "fileformat", icons_enabled = false },
			{ "progress" },
		},
		lualine_z = {
			{
				location,
				separator = { left = "", right = "" },
				padding = { left = 0, right = 0 },
			},
		},
	},
}

local tty_theme = {
	options = {
		section_separators = "",
		icons_enabled = false,
	},
	sections = {
		lualine_a = {
			"mode",
		},
		lualine_y = {
			"encoding",
			"fileformat",
			"progress",
		},
		lualine_z = {
			location,
		},
	},
}

-- Use different themes if Neovim is being ran on a TTY enviroment or not.
local config = vim.tbl_deep_extend("force", opts, global_sections, vim.env.DISPLAY ~= nil and theme or tty_theme)

lualine.setup(config)

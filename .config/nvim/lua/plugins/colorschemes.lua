return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = true,
		priority = 1000,
	},
	{
		"RedsXDD/neopywal.nvim",
		branch = "testing",
		name = "neopywal",
		lazy = false,
		priority = 1000,
		opts = {
			use_wallust = true,
			transparent = true,
			default_fileformats = true,
			default_plugins = true,
			custom_highlights = function(colors)
				local U = require("neopywal.util")
				return {
					CmpItemKindKeyword = { bg = colors.color1, fg = colors.background }, -- Link Keyword
					CmpItemKindOperator = { link = "CmpItemKindKeyword" }, -- Link Operator
					CmpItemKindEnum = { link = "CmpItemKindKeyword" },
					CmpItemKindFunction = { bg = colors.color2, fg = colors.background }, -- Link Function
					CmpItemKindField = { link = "CmpItemKindFunction" }, -- Link @variable.member
					CmpItemKindProperty = { link = "CmpItemKindFunction" }, -- Link @property
					CmpItemKindMethod = { link = "CmpItemKindFunction" },
					CmpItemKindColor = { bg = colors.color3, fg = colors.background },
					CmpItemKindInterface = { bg = colors.color4, fg = colors.background },
					CmpItemKindFolder = { link = "CmpItemKindInterface" }, -- Link Directory
					CmpItemKindVariable = { link = "CmpItemKindInterface" }, -- Link Variable
					CmpItemKindEvent = { link = "CmpItemKindVariable" },
					CmpItemKindConstructor = { bg = colors.color5, fg = colors.background }, -- Link Special
					CmpItemKindModule = { link = "CmpItemKindConstructor" }, -- Link Include
					CmpItemKindUnit = { link = "CmpItemKindConstructor" }, -- Link Number
					CmpItemKindSnippet = { link = "CmpItemKindModule" },
					CmpItemKindClass   = { bg = colors.color6, fg = colors.background }, -- Link StorageClass
					CmpItemKindStruct  = { link = "CmpItemKindClass" }, -- Link Structure
					CmpItemKindCopilot = { link = "CmpItemKindClass" },
					CmpItemKindTabNine = { link = "CmpItemKindClass" },
					CmpItemKindTypeParameter = { bg = colors.color11, fg = colors.background }, -- Link Identifier
					CmpItemKindConstant = { link = "CmpItemKindTypeParameter" }, -- Link Constant
					CmpItemKindValue = { link = "CmpItemKindTypeParameter" },
					CmpItemKindEnumMember = { link = "CmpItemKindTypeParameter" },
					CmpItemKindText = { bg = U.lighten(colors.background, 0.3), fg = colors.foreground },
					CmpItemKindFile = { link = "CmpItemKindText" },
					CmpItemKindReference = { link = "CmpItemKindText" },
				}
			end,
		},
		config = function(_, opts)
			local neopywal = require("neopywal")
			neopywal.setup(opts)

			if vim.env.DISPLAY ~= nil then
				vim.cmd.colorscheme("neopywal")
			else
				vim.cmd([[set notermguicolors]])
				vim.cmd.colorscheme("default")
			end
		end,
	},
}

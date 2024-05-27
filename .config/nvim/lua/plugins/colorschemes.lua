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
			transparent = false,
			default_fileformats = false,
			default_plugins = true,
			custom_highlights = function(colors)
				return {
					CmpItemKindSnippet = { bg = colors.color5, fg = colors.background },
					CmpItemKindKeyword = { bg = colors.color1, fg = colors.background },
					CmpItemKindText = { bg = colors.color6, fg = colors.background },
					CmpItemKindMethod = { bg = colors.color4, fg = colors.background },
					CmpItemKindConstructor = { bg = colors.color4, fg = colors.background },
					CmpItemKindFunction = { bg = colors.color4, fg = colors.background },
					CmpItemKindFolder = { bg = colors.color4, fg = colors.background },
					CmpItemKindModule = { bg = colors.color4, fg = colors.background },
					CmpItemKindConstant = { bg = colors.color11, fg = colors.background },
					CmpItemKindField = { bg = colors.color2, fg = colors.background },
					CmpItemKindProperty = { bg = colors.color2, fg = colors.background },
					CmpItemKindEnum = { bg = colors.color2, fg = colors.background },
					CmpItemKindUnit = { bg = colors.color2, fg = colors.background },
					CmpItemKindClass = { bg = colors.color3, fg = colors.background },
					CmpItemKindVariable = { bg = colors.color3, fg = colors.background },
					CmpItemKindFile = { bg = colors.color4, fg = colors.background },
					CmpItemKindInterface = { bg = colors.color3, fg = colors.background },
					CmpItemKindColor = { bg = colors.color1, fg = colors.background },
					CmpItemKindReference = { bg = colors.color1, fg = colors.background },
					CmpItemKindEnumMember = { bg = colors.color1, fg = colors.background },
					CmpItemKindStruct = { bg = colors.color4, fg = colors.background },
					CmpItemKindValue = { bg = colors.color11, fg = colors.background },
					CmpItemKindEvent = { bg = colors.color4, fg = colors.background },
					CmpItemKindOperator = { bg = colors.color4, fg = colors.background },
					CmpItemKindTypeParameter = { bg = colors.color4, fg = colors.background },
					CmpItemKindCopilot = { bg = colors.color6, fg = colors.background },
					CmpItemKindTabNine = { bg = colors.color6, fg = colors.background },
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

local neopywal = require("neopywal")

vim.g.neopywal_debug = true

neopywal.setup({
	use_wallust = true,
	transparent_background = false,
	dim_inactive = true,
	show_split_lines = false,
	custom_highlights = function(colors)
		local U = require("neopywal.utils.color")
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
			CmpItemKindClass = { bg = colors.color6, fg = colors.background }, -- Link StorageClass
			CmpItemKindStruct = { link = "CmpItemKindClass" }, -- Link Structure
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
})

local has_neopywal, neopywal = pcall(require, "neopywal")
if not has_neopywal then
	return
end

vim.g.neopywal_debug = true

neopywal.setup({
	use_wallust = true,
	transparent_background = false,
	dim_inactive = true,
	show_split_lines = false,
	default_plugins = false,
	plugins = {
		dashboard = true,
		gitsigns = true,
		lazy = true,
		lsp = true,
		netrw = true,
		noice = true,
		notify = true,
		nvim_cmp = true,
		treesitter = true,
		flash = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		mini = {
			hipatterns = true,
			indentscope = true,
		},
	},
	custom_highlights = function(C)
		local U = require("neopywal.utils.color")
		return {
			CmpItemKindKeyword = { fg = C.keyword, styles = { "reverse" } },
			CmpItemKindOperator = { fg = C.operator, styles = { "reverse" } },
			CmpItemKindEnum = { link = "CmpItemKindKeyword" },
			CmpItemKindFunction = { fg = C.func, styles = { "reverse" } },
			CmpItemKindField = { fg = C.variable, styles = { "reverse" } },
			CmpItemKindProperty = { fg = C.func, styles = { "reverse" } },
			CmpItemKindMethod = { link = "CmpItemKindFunction" },
			CmpItemKindColor = { fg = C.color3, styles = { "reverse" } },
			CmpItemKindInterface = { fg = C.color4, styles = { "reverse" } },
			CmpItemKindFolder = { fg = C.directory, styles = { "reverse" } },
			CmpItemKindVariable = { fg = C.variable, styles = { "reverse" } },
			CmpItemKindEvent = { link = "CmpItemKindVariable" },
			CmpItemKindConstructor = { fg = C.special, styles = { "reverse" } },
			CmpItemKindModule = { fg = C.include, styles = { "reverse" } },
			CmpItemKindUnit = { fg = C.number, styles = { "reverse" } },
			CmpItemKindSnippet = { link = "CmpItemKindModule" },
			CmpItemKindClass = { fg = C.storageclass, styles = { "reverse" } },
			CmpItemKindStruct = { fg = C.structure, styles = { "reverse" } },
			CmpItemKindCopilot = { fg = C.color6, styles = { "reverse" } },
			CmpItemKindTabNine = { fg = C.color6, styles = { "reverse" } },
			CmpItemKindTypeParameter = { fg = C.identifier, styles = { "reverse" } },
			CmpItemKindConstant = { fg = C.constant, styles = { "reverse" } },
			CmpItemKindValue = { link = "CmpItemKindConstant" },
			CmpItemKindEnumMember = { link = "CmpItemKindConstant" },
			CmpItemKindText = { bg = U.lighten(C.background, 30), fg = C.foreground },
			CmpItemKindFile = { link = "CmpItemKindText" },
			CmpItemKindReference = { link = "CmpItemKindText" },
		}
	end,
})

neopywal.load()

local M = {}
M.icons = {}

--[[
	NOTE: The `set_icons` function creates a table inside M.icons with the name given from the `table_name` argument.
	The table `table_name` either:
		- Contains a set of icons for when neovim is not opened on a TTY enviroment
		- Contains a set strings of text that are TTY compatible for when neovim is opened on a TTY enviroment
--]]
local function set_icons(table_name, normal_icons, tty_icons)
    local icons_table = {}

    if vim.env.DISPLAY ~= nil then
        icons_table = normal_icons
    else
        icons_table = tty_icons
    end

    M.icons[table_name] = icons_table
end

set_icons("misc", { dots = "󰇘" }, { dots = "..." })

set_icons("listchars", {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	extends = "▸",
	precedes = "◂"
}, {
	tab = "- ",
	trail = ".",
	nbsp = "_",
	extends = ">",
	precedes = "<"
})

set_icons("fillchars", {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}, {
	foldopen = "-",
	foldclose = ">",
	fold = " ",
	foldsep = " ",
	diff = "/",
	eob = " ",
})

set_icons("dap", {
	Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint          = " ",
	BreakpointCondition = " ",
	BreakpointRejected  = { " ", "DiagnosticError" },
	LogPoint            = ".>",
}, {
	Stopped             = { "-", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint          = "*",
	BreakpointCondition = "?",
	BreakpointRejected  = { "!", "DiagnosticError" },
	LogPoint            = ".>",
})

set_icons("mason", {
	installed = "✓",
	pending = "➜",
	uninstalled = "✗",
}, {
	installed = "*",
	pending = ">",
	uninstalled = "X",
})

set_icons("diagnostics", {
	Error = " ",
	Warn  = " ",
	Hint  = " ",
	Info  = " ",
}, {
	Error = "E",
	Warn  = "W",
	Hint  = "H",
	Info  = "I",
})

set_icons("git", {
	added    = " ",
	modified = " ",
	removed  = " ",
}, {
	added    = "A",
	modified = "M",
	removed  = "R",
})

set_icons("gitsigns", {
	add = "▎",
	change = "▎",
	delete = "",
	topdelete = "",
	changedelete = "▎",
	untracked = "▎",
}, {
	add = "+",
	change = "~",
	delete = "-",
	topdelete = "^",
	changedelete = "<",
	untracked = "?",
})

set_icons("starter", {
	footer = "󱐋 ",
	bullet = "░ ",
	recent_files = " ",
	sections = {
		actions = "󱓞 ",
		recent_files = "󰥔 ",
		session = "󰍹 ",
	},
	actions = {
		new_file      = " ",
		quit          = "󰅚 ",
		file_explorer = "󰉋 ",
		list_buffers  = "󰮊 ",
		recent_files  = " ",
		find_files    = "󰱼 ",
		live_grep     = "󰈬 ",
		lazy          = "󰒲 ",
		mason         = " ",
	},
}, {
	footer = "=> ",
	bullet = "* ",
	recent_files = "",
	sections = {
		actions = "",
		recent_files = "",
		session = "",
	},
	actions = {
		new_file      = "",
		quit          = "",
		file_explorer = "",
		list_buffers  = "",
		recent_files  = "",
		find_files    = "",
		live_grep     = "",
		lazy          = "",
		mason         = "",
	},
})

set_icons("kinds", {
	Array         = " ",
	Boolean       = "󰨙 ",
	Class         = " ",
	Codeium       = "󰘦 ",
	Color         = "󰏘 ",
	Control       = " ",
	Collapsed     = " ",
	Constant      = "󰏿 ",
	Constructor   = " ",
	Copilot       = " ",
	Enum          = " ",
	EnumMember    = " ",
	Event         = " ",
	Field         = " ",
	File          = "󰈙 ",
	Folder        = " ",
	Function      = "󰊕 ",
	Interface     = " ",
	Key           = " ",
	Keyword       = "󰌋 ",
	Method        = "󰊕 ",
	Module        = " ",
	Namespace     = "󰦮 ",
	Null          = " ",
	Number        = "󰎠 ",
	Object        = " ",
	Operator      = " ",
	Package       = " ",
	Property      = "󰜢 ",
	Reference     = " ",
	Snippet       = " ",
	String        = " ",
	Struct        = "󰆼 ",
	TabNine       = "󰏚 ",
	Text          = " ",
	TypeParameter = " ",
	Unit          = "󰑭 ",
	Value         = " ",
	Variable      = "󰀫 ",
}, {
	Array         = "Array",
	Boolean       = "Boolean",
	Class         = "Class",
	Codeium       = "Codeium",
	Color         = "Color",
	Control       = "Control",
	Collapsed     = "Collapsed",
	Constant      = "Constant",
	Constructor   = "Constructor",
	Copilot       = "Copilot",
	Enum          = "Enum",
	EnumMember    = "EnumMember",
	Event         = "Event",
	Field         = "Field",
	File          = "File",
	Folder        = "Folder",
	Function      = "Function",
	Interface     = "Interface",
	Key           = "Key",
	Keyword       = "Keyword",
	Method        = "Method",
	Module        = "Module",
	Namespace     = "Namespace",
	Null          = "Null",
	Number        = "Number",
	Object        = "Object",
	Operator      = "Operator",
	Package       = "Package",
	Property      = "Property",
	Reference     = "Reference",
	Snippet       = "Snippet",
	String        = "String",
	Struct        = "Struct",
	TabNine       = "TabNine",
	Text          = "Text",
	TypeParameter = "TypeParameter",
	Unit          = "Unit",
	Value         = "Value",
	Variable      = "Variable",
})

return M

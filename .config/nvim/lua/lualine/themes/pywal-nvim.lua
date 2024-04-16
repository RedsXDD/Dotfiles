-- Lualine variable formatting:
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

local core = require("pywal.core")
local colors = core.get_colors()

local pywal = {}

pywal.normal = {
	a = { bg = colors.color4, fg = colors.background, gui = "bold" },
	b = { bg = colors.foreground, fg = colors.background, gui = "bold" },
	c = { bg = colors.color8, fg = colors.foreground, gui = "bold" },
	x = { bg = colors.color8, fg = colors.foreground, gui = "bold" },
	y = { bg = colors.foreground, fg = colors.background, gui = "bold" },
	z = { bg = colors.color4, fg = colors.background, gui = "bold" },
}

pywal.visual = {
	a = { bg = colors.color5, fg = colors.background, gui = "bold" },
	z = { bg = colors.color5, fg = colors.background, gui = "bold" },
}

pywal.insert = {
	a = { bg = colors.color6, fg = colors.background, gui = "bold" },
	z = { bg = colors.color6, fg = colors.background, gui = "bold" },
}

pywal.command = {
	a = { bg = colors.color1, fg = colors.background, gui = "bold" },
	z = { bg = colors.color1, fg = colors.background, gui = "bold" },
}

pywal.replace = {
	a = { bg = colors.color3, fg = colors.background, gui = "bold" },
	z = { bg = colors.color3, fg = colors.background, gui = "bold" },
}

pywal.inactive = {
	a = { bg = colors.background, fg = colors.foreground, gui = "bold" },
	z = { bg = colors.background, fg = colors.foreground, gui = "bold" },
}

return pywal

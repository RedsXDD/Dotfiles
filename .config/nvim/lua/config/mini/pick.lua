local pick = require("mini.pick")
local border_style = require("user.icons").misc.border
local icons = require("user.icons").pick

local win_config = function() -- Function to center mini.pick on screen.
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		border = border_style,
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

pick.setup({
	window = {
		config = win_config(),
		prompt_cursor = icons.prompt_cursor,
		prompt_prefix = icons.prompt_prefix,
	},
	options = {
		content_from_bottom = true,
		use_cache = true,
	},
})

-- Pull in the wezterm API
local wezterm = require("wezterm")

return {
	color_scheme = "Wallust",
	font_size = 14,
	font = wezterm.font("JetBrainsMono NF"),

	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},

	window_background_opacity = 0.85,
	window_decorations = "NONE",
	enable_tab_bar = false,
	scrollback_lines = 100000,
	enable_scroll_bar = false,
	check_for_updates = false,
	max_fps = 144,
}

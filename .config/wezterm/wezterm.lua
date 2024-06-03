-- Pull in the wezterm API
local wezterm = require("wezterm")

return {
	term = "wezterm",
	color_scheme = "Wallust",
	font_size = 14,
	font = wezterm.font("FiraMonoNerdFont"),
	warn_about_missing_glyphs = false,
	window_background_opacity = 0.85,
	window_decorations = "NONE",
	enable_tab_bar = false,
	scrollback_lines = 100000,
	enable_scroll_bar = false,
	check_for_updates = false,

	-- Keybindings:
	disable_default_key_bindings = true,
	keys = {
		-- Activate Vi mode
		{
			key = "Space",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateCopyMode,
		},
		-- Search
		{
			key = "/",
			mods = "CTRL|ALT",
			action = wezterm.action.Search({ CaseSensitiveString = "" }),
		},
		-- Clipboard
		{
			key = "y",
			mods = "ALT",
			action = wezterm.action.CopyTo("Clipboard"),
		},
		{
			key = "p",
			mods = "ALT",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
		-- Font size
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DecreaseFontSize,
		},
		{
			key = "=",
			mods = "CTRL",
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "0",
			mods = "CTRL",
			action = wezterm.action.ResetFontSize,
		},
	},
}

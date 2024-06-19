-- Pull in the wezterm API
local wezterm = require("wezterm")

wezterm.on("reduce_opacity", function(window)
	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1
	end

	overrides.window_background_opacity = math.max(0, overrides.window_background_opacity - 0.05)

	window:set_config_overrides(overrides)
end)

wezterm.on("increase_opacity", function(window)
	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1
	end

	overrides.window_background_opacity = math.min(overrides.window_background_opacity + 0.05, 1)

	window:set_config_overrides(overrides)
end)

wezterm.on("toggle_opacity", function(window)
	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.5
	else
		overrides.window_background_opacity = nil
	end

	window:set_config_overrides(overrides)
end)

return {
	term = "wezterm",
	color_scheme = "Wallust",
	font_size = 14,
	font = wezterm.font("JetBrainsMonoNerdFont"),
	warn_about_missing_glyphs = false,
	window_background_opacity = 1,
	window_decorations = "NONE",
	enable_tab_bar = false,
	scrollback_lines = 100000,
	enable_scroll_bar = false,
	check_for_updates = false,
	exit_behavior = "Close",

	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

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
		-- Opacity
		{
			key = "-",
			mods = "CTRL|ALT",
			action = wezterm.action.EmitEvent("reduce_opacity"),
		},
		{
			key = "=",
			mods = "CTRL|ALT",
			action = wezterm.action.EmitEvent("increase_opacity"),
		},
		{
			key = "0",
			mods = "CTRL|ALT",
			action = wezterm.action.EmitEvent("toggle_opacity"),
		},
	},
}

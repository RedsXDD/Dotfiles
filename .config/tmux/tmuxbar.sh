#!/usr/bin/env bash

# ----------------------------------------------------------- #

# ████████╗███╗   ███╗██╗   ██╗██╗  ██╗██████╗  █████╗ ██████╗
# ╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝██╔══██╗██╔══██╗██╔══██╗
#    ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ██████╔╝███████║██████╔╝
#    ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ██╔══██╗██╔══██║██╔══██╗
#    ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗██████╔╝██║  ██║██║  ██║
#    ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
# ----------------------------------------------------------- #

# Main option setting functions.
set() {
	local option="$1"
	shift

	local value=''
	value="$(printf '%s' "$@")"
	tmux set-option -gq "$option" "$value"
}

setw() {
	local option="$1"
	shift

	local value=''
	value="$(printf '%s' "$@")"
	tmux set-window-option -gq "$option" "$value"
}

# Default variables:
theme() {
	local pane_sync_symbol=''
	local pane_mode_symbol='󰧑'
	local pane_zoom_symbol='󰍋'
	local pane_default_symbol='󰮊'
	local mode_symbol="#{?pane_in_mode,$pane_mode_symbol,#{?window_zoomed_flag,$pane_zoom_symbol,#{?pane_synchronized,$pane_sync_symbol,$pane_default_symbol}}}"

	# Left statusbar:
	set status-left "#[none,bold,#{?client_prefix,fg=$prefix_active_color,fg=$prefix_color}]$mode_symbol #S "

	# Right statusbar:
	set status-right \
		" " \
		"#[none,bold,fg=$date_color]%a %d/%m   " \
		"#[none,bold,fg=$time_color]%H:%M  "

	# Currently active window style:
	set window-status-current-format \
		"#[none,bold,fg=$active_window_color]#I#{?pane_in_mode,tmux,#W}" \

	# Inactive window style:
	set window-status-format \
		"#[none,bold,#{?window_last_flag,fg=$last_window_color,fg=$normal_window_color}]" \
		"#I" \
		"#{?window_last_flag,*,}" \
		"#{?pane_in_mode,tmux,#W}"
}

tty_theme() {
	local pane_sync_symbol='*'
	local pane_mode_symbol='@'
	local pane_zoom_symbol='+'
	local pane_default_symbol='$'
	local mode_symbol="#{?pane_in_mode,$pane_mode_symbol,#{?window_zoomed_flag,$pane_zoom_symbol,#{?pane_synchronized,$pane_sync_symbol,$pane_default_symbol}}}"

	# Left statusbar:
	set status-left "#[none,bold,#{?client_prefix,fg=$prefix_active_color,fg=$prefix_color}]($mode_symbol)[#S] "

	# Right statusbar:
	set status-right " #[none,bold,fg=$time_color]%a, %d/%m, %H:%M"

	# Currently active window style:
	set window-status-current-format \
		"#[none,bold,fg=$active_window_color]#I:#{?pane_in_mode,tmux,#W}" \

	# Inactive window style:
	set window-status-format \
		"#[none,bold,#{?window_last_flag,fg=$last_window_color,fg=$normal_window_color}]" \
		"#I" \
		"#{?window_last_flag,*,:}" \
		"#{?pane_in_mode,tmux,#W}"
}

# Apply wallust/pywal theme if existent (only if tmux is not being ran inside a TTY).
# shellcheck source=/dev/null
if [ -n "$DISPLAY" ]; then
	if [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/wal/colors.sh" ]; then
		. "${XDG_CACHE_HOME:-$HOME/.cache}/wal/colors.sh"
	elif [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/wallust/colors.sh" ]; then
		. "${XDG_CACHE_HOME:-$HOME/.cache}/wallust/colors.sh"
	fi
fi

# Main color variables:
background="${background:-color0}"
foreground="${foreground:-color7}"
txt_color="$foreground"
prefix_color="color6"
prefix_active_color="color1"
date_color="$txt_color"
time_color="$txt_color"
normal_window_color="$txt_color"
active_window_color="color2"
last_window_color="$txt_color"

# General status bar options:
set window-status-separator '  ' # Window separator.
set status-left-length 100       # Left status bar length.
set status-right-length 100      # Right status bar length.
set status-left-style default    # Default left status bar style.
set status-right-style default   # Default right status bar style.
set status-position top          # Set status bar posisiton.
set status-justify centre        # Center window status bar.

# General styling:
setw clock-mode-colour "color4"                       # Clock mode.
setw mode-style "bg=$background,fg=color5,bold"       # Copy mode.
set pane-border-style "fg=$foreground"                # Default pane border color.
set pane-active-border-style "fg=color4"              # Active pane border color.
set status-style "bg=$background,fg=$foreground,bold" # Default statusbar style.

# Message statusbar style:
set message-style "#{?pane_active,bg=$background,bg=color6},fg=color6,bold"
set message-command-style "#{?pane_active,bg=$background,bg=color8},fg=color8,bold"

# Change the statusbar style depending if tmux is being ran on a TTY enviroment or not.
[ -z "$DISPLAY" ] && tty_theme && exit 0
theme

# Apply window icon names:
[ -n "$DISPLAY" ] && [ -f "$HOME/.config/tmux/window_icons.sh" ] && set automatic-rename-format "#($HOME/.config/tmux/window_icons.sh #{pane_current_command} #{window_panes})"

# vim:fileencoding=utf-8:foldmethod=marker

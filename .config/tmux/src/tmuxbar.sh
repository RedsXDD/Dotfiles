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

theme() {
	local pane_sync_symbol=''
	local pane_mode_symbol='󰧑'
	local pane_zoom_symbol='󰍋'
	local pane_default_symbol='󰮊'
	local mode_symbol="#{?pane_in_mode,$pane_mode_symbol,#{?window_zoomed_flag,$pane_zoom_symbol,#{?pane_synchronized,$pane_sync_symbol,$pane_default_symbol}}}"

	# Left statusbar:
	git_status="#(${SRCDIR}/git_status.sh #{pane_current_path})"
	set status-left "#[none,bold,#{?client_prefix,fg=$prefix_active_color,fg=$prefix_color}]$mode_symbol #[none,bold,fg=$txt_color]#S ${git_status} "

	# Right statusbar:
	set status-right \
		" " \
		"#[none,bold,fg=$txt_color]#H #[none,bold,fg=$hostname_color]  " \
		"#[none,bold,fg=$txt_color]%d-%b-%y #[none,bold,fg=$date_color]  " \
		"#[none,bold,fg=$txt_color]%H:%M #[none,bold,fg=$time_color] "

	# Currently active window style:
	set window-status-current-format "#[none,bold,fg=$active_window_color]#I#W"

	# Inactive window style:
	set window-status-format "#[none,bold,#{?window_last_flag,fg=$last_window_color,fg=$normal_window_color}]#I#{?window_last_flag,*,}#W"
}

tty_theme() {
	local pane_sync_symbol='*'
	local pane_mode_symbol='@'
	local pane_zoom_symbol='+'
	local pane_default_symbol='$'
	local mode_symbol="#{?pane_in_mode,$pane_mode_symbol,#{?window_zoomed_flag,$pane_zoom_symbol,#{?pane_synchronized,$pane_sync_symbol,$pane_default_symbol}}}"

	# Left statusbar:
	set status-left "#[none,bold,#{?client_prefix,fg=$prefix_active_color,fg=$prefix_color}]($mode_symbol) #[none,bold,fg=$txt_color]#S "

	# Right statusbar:
	set status-right \
		" " \
		"#[none,bold,fg=$txt_color]#H#[none,bold,fg=$hostname_color]:H" "  " \
		"#[none,bold,fg=$txt_color]%d-%b-%y#[none,bold,fg=$date_color]:D" "  " \
		"#[none,bold,fg=$txt_color]%H:%M#[none,bold,fg=$time_color]:T" "  "

	# Currently active window style:
	set window-status-current-format "#[none,bold,fg=$active_window_color]#I:#W"

	# Inactive window style:
	set window-status-format "#[none,bold,#{?window_last_flag,fg=$last_window_color,fg=$normal_window_color}]#I#{?window_last_flag,*,:}#W"
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

# Main variables:
SRCDIR="${XDG_CONFIG_HOME:-HOME/.config}/tmux/src"
background="${background:-color0}"
foreground="${foreground:-color7}"
txt_color="$foreground"
prefix_color="color6"
prefix_active_color="color1"
hostname_color="color11"
date_color="color5"
time_color="color6"
normal_window_color="$txt_color"
active_window_color="color2"
last_window_color="$txt_color"

# General statusbar options:
set window-status-separator '  ' # Window separator.
set status-left-length 100       # Left statusbar length.
set status-right-length 100      # Right statusbar length.
set status-left-style default    # Default left statusbar style.
set status-right-style default   # Default right statusbar style.
set status-position top          # Set statusbar posisiton.
set status-justify centre        # Window statusbar position.

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
[ -n "$DISPLAY" ] && [ -f "${SRCDIR}/window_icons.sh" ] && set automatic-rename-format "#(${SRCDIR}/window_icons.sh #{pane_current_command} #{window_panes})"

# vim:fileencoding=utf-8:foldmethod=marker

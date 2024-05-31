#!/usr/bin/env sh

# Modified version of joshmedeski tmux-nerd-font-window-name plugin
# https://github.com/joshmedeski/tmux-nerd-font-window-name/tree/main

if ! command -v yq >/dev/null 2>&1; then
	echo "$1 ⚠︎ yq missing"
	exit 1
fi

NAME="$1"
PANES="$2"
CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/window_icons.yml"

get_config_value() {
	key=$1
	value="$(yq "$key" "$CONFIG_FILE")"
	echo "$value" | sed 's/"//g'
}

ICON="$(get_config_value ".icons.\"$NAME\"")"

if [ "$ICON" = "null" ]; then
	FALLBACK_ICON="$(get_config_value '.config.fallback-icon')"
	ICON="$FALLBACK_ICON"
fi

SHOW_MULTI_PANE_ICON="$(get_config_value '.config.show_multi_pane_icon')"
if [ "$SHOW_MULTI_PANE_ICON" = true ] && [ "$PANES" -gt 1 ]; then
	MULTI_PANE_ICON="$(get_config_value '.config.multi_pane_icon')"
	if [ "$MULTI_PANE_ICON" != "null" ]; then
		ICON="$MULTI_PANE_ICON $ICON"
	fi
fi

SHOW_NAME="$(get_config_value '.config.show_name')"
if [ "$SHOW_NAME" = true ]; then
	NAME_POSITION="$(get_config_value '.config.name_position')"
	if [ "$NAME_POSITION" = "right" ]; then
		ICON="$ICON $NAME"
	else
		ICON="$NAME $ICON"
	fi
fi

echo "$ICON"

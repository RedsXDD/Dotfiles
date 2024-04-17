# vim:fileencoding=utf-8:foldmethod=marker:filetype=tmux

# ----------------------------------------------------------- #

# ████████╗███╗   ███╗██╗   ██╗██╗  ██╗██████╗  █████╗ ██████╗
# ╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝██╔══██╗██╔══██╗██╔══██╗
#    ██║   ██╔████╔██║██║   ██║ ╚███╔╝ ██████╔╝███████║██████╔╝
#    ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗ ██╔══██╗██╔══██║██╔══██╗
#    ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗██████╔╝██║  ██║██║  ██║
#    ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

# ----------------------------------------------------------- #

# Default variables:
background_color='{background}'
foreground_color='{foreground}'
txt_color="$background_color"
pane_sync_symbol=''
pane_mode_symbol='󰧑'
pane_zoom_symbol='󰍋'
pane_default_symbol=''

# General styling:
setw -g clock-mode-colour color4                # Clock mode.
setw -g mode-style "bg=color0,fg=color5,bold"   # Copy mode.
set -g pane-border-style "fg=$foreground_color" # Default pane border color.
set -g pane-active-border-style fg=color4       # Active pane border color.
set -g status-style "bg=$background_color,fg=$foreground_color,bold" # Default status bar style.

# Message status bar style:
set -g message-style         "#{{?pane_active,bg=color3,bg=$background_color}},fg=$txt_color,bold"
set -g message-command-style "#{{?pane_active,bg=$background_color,bg=color3}},fg=color3,bold"

# Left status bar:
set -g status-left "#[none,bg=$background_color,#{{?client_prefix,fg=color1,fg=color4}}]\
			#[none,#{{?client_prefix,bg=color1,bg=color4}},fg=$txt_color,bold]󰮊 \
			#[none,bg=$foreground_color,fg=$txt_color,bold] #S\
			#[none,bg=$background_color,fg=$foreground_color]"

# Right status bar:
set -g status-right " \
			#[none,bg=$background_color,fg=$foreground_color]\
			#[none,bg=$foreground_color,fg=$txt_color,bold]%a, %d %b %Y, %H:%M \
			#[none,bg=color4,fg=$txt_color,bold]  \
			#[none,bg=$background_color,fg=color4]"

# Inactive window style:
set -g window-status-format " \
				#[none,bg=$background_color,#{{?window_last_flag,fg=color5,fg=$foreground_color}},bold]\
				#{{?window_last_flag,[,}}\
				#{{?pane_in_mode,$pane_mode_symbol,#{{?window_zoomed_flag,$pane_zoom_symbol,#{{?pane_synchronized,$pane_sync_symbol,$pane_default_symbol}}}}}} \
				#I\
				#{{?window_last_flag,],}}"

# Currently active window style:
set -g window-status-current-format " \
					#[none,bg=$background_color,fg=$foreground_color]\
					#[none,bg=$foreground_color,fg=$txt_color,bold]#W #{{?pane_in_mode,$pane_mode_symbol,#{{?window_zoomed_flag,$pane_zoom_symbol,#{{?pane_synchronized,$pane_sync_symbol,$pane_default_symbol}}}}}} \
					#[none,#{{?pane_in_mode,bg=color3,bg=color2}},fg=$txt_color,bold] #I\
					#[none,bg=$background_color,#{{?pane_in_mode,fg=color3,fg=color2}}]"

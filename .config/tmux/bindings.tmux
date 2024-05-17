# vim:fileencoding=utf-8:foldmethod=marker:filetype=tmux

# -------------------------------------------------------------------------------------------------- #

# ████████╗███╗   ███╗██╗   ██╗██╗  ██╗    ██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
# ╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝    ██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
#    ██║   ██╔████╔██║██║   ██║ ╚███╔╝     ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
#    ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗     ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
#    ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗    ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
#    ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

# -------------------------------------------------------------------------------------------------- #

#: Unbind-keys {{{
# Buffers:
unbind-key '#' # List all paste buffers.
unbind-key '-' # Delete the most recent paste buffer.
unbind-key '=' # Choose a paste buffer from a list.
unbind-key ']' # Paste the most recent paste buffer.

# Copy mode:
unbind-key '[' # Enter copy mode.

# Sessions/clients:
unbind-key '$' # Rename current session

# Pane management:
unbind-key '"'     # Split window vertically.
unbind-key '%'     # Split window horizontally.
unbind-key "'"     # Prompt for window index to select.
unbind-key 'C-o'   # Rotate through the panes.
unbind-key 'M-o'   # Rotate through the panes in reverse.
unbind-key 'Left'  # Select the pane to the left of the active pane.
unbind-key 'Down'  # Select the pane below the active pane.
unbind-key 'Up'    # Select the pane above the active pane.
unbind-key 'Right' # Select the pane to the right of the active pane.

# Window management:
unbind-key 'n'       # Select the next window
unbind-key 'p'       # Select the previous window
unbind-key 'l'       # Select the previously current window
unbind-key 'w'       # Choose a window from a list.
unbind-key 'c'       # Create a new window.
unbind-key 'C'       # Customize options.
unbind-key '&'       # Kill current window.
unbind-key ','       # Rename current window.
unbind-key 'C-Left'  # Resize the pane left.
unbind-key 'C-Down'  # Resize the pane down.
unbind-key 'C-Up'    # Resize the pane up.
unbind-key 'C-Right' # Resize the pane right.

# Complete removal:
unbind-key '0'       # Select window 0.
unbind-key 'i'       # Display window information.
unbind-key '.'       # Move the current window.
unbind-key 'DC'      # Reset so the visible part of the window follows the cursor.
unbind-key 'PPage'   # Enter copy mode and scroll up.
unbind-key 'M-Left'  # Resize the pane left by 5.
unbind-key 'M-Down'  # Resize the pane down by 5.
unbind-key 'M-Up'    # Resize the pane up by 5.
unbind-key 'M-Right' # Resize the pane right by 5.
unbind-key 'S-Left'  # Move the visible part of the window left.
unbind-key 'S-Down'  # Move the visible part of the window down.
unbind-key 'S-Up'    # Move the visible part of the window up.
unbind-key 'S-Right' # Move the visible part of the window right.
#: }}}
#: General {{{
# Remap prefix from Ctrl+b to Ctrl+s.
unbind-key 'C-b'
set-option -g prefix 'C-a'
bind-key 'C-a' send-prefix

bind-key 'M-c' customize-mode -Z # Toggle customize mode.
bind-key 'R' source-file ~/.config/tmux/tmux.conf\; display 'Tmux config reloaded!' # Reload tmux config.
#: }}}
#: Copy mode & buffer management {{{
# Enter and navigate copy mode:
bind-key 'Space' copy-mode
bind-key -T copy-mode-vi 'q'   send -X cancel
bind-key -T copy-mode-vi 'y'   send -X copy-selection-and-cancel
bind-key -T copy-mode-vi 'H'   send -X start-of-line
bind-key -T copy-mode-vi 'L'   send -X end-of-line
bind-key -T copy-mode-vi 'v'   send -X begin-selection
bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle

# Buffer management:
bind-key 'b' list-buffers    # List all paste buffers
bind-key 'B' delete-buffer   # Delete the most recent paste buffer
bind-key 'p' paste-buffer -p # Paste the most recent paste buffer
bind-key 'P' choose-buffer   # Choose a paste buffer from a list
#: Clipboard {{{
# Copy to X11 clipboard:
# if -b 'command -v xsel >/dev/null 2>&1' 'bind-key y run -b "\"\$TMUX_PROGRAM\" \${TMUX_SOCKET:+-S \"\$TMUX_SOCKET\"} save-buffer - | xsel -i -b"'
# if -b '! command -v xsel >/dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind-key y run -b "\"\$TMUX_PROGRAM\" \${TMUX_SOCKET:+-S \"\$TMUX_SOCKET\"} save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'

# Copy to Wayland clipboard:
if -b 'command -v wl-copy >/dev/null 2>&1' 'bind-key y run -b "\"\$TMUX_PROGRAM\" \${TMUX_SOCKET:+-S \"\$TMUX_SOCKET\"} save-buffer - | wl-copy"'
#: }}}
#: }}}
#: Pane management {{{
bind-key '-' split-window -hc "$HOME"                # Split window horizontally.
bind-key '_' split-window -vc "$HOME"                # Split window vertically.
bind-key '=' split-window -hc "#{pane_current_path}" # Split window horizontally on CWD.
bind-key '+' split-window -vc "#{pane_current_path}" # Split window vertically on CWD.

bind-key '[' rotate-window    # Rotate through the panes.
bind-key ']' rotate-window -D # Rotate through the panes in reverse.
bind-key '{' previous-layout  # Switch to the previous layout.
bind-key '}' next-layout      # Switch to the next layout.

bind-key -n 'M-n' select-pane -t :.+ # Select the next pane.
bind-key -n 'M-p' select-pane -t :.- # Select the previous pane.
bind-key -n 'M-h' select-pane -L     # Select the left pane.
bind-key -n 'M-j' select-pane -D     # Select the above pane.
bind-key -n 'M-k' select-pane -U     # Select the below pane.
bind-key -n 'M-l' select-pane -R     # Select the right pane.

bind-key -n 'S-Left'  resize-pane -L 1 # Resize pane to the left.
bind-key -n 'S-Down'  resize-pane -D 1 # Resize pane to the bottom.
bind-key -n 'S-Up'    resize-pane -U 1 # Resize pane to the top.
bind-key -n 'S-Right' resize-pane -R 1 # Resize pane to the right.

bind-key "'" switch-client -t'{marked}' # Switch to the marked pane.
bind-key 'Y' set-window-option synchronize-panes\; display 'Synchronize mode toggled.' # Synchronize panes on currently active window.
#: }}}
#: Window management {{{
bind-key 'c' new-window -c "$HOME" # Create a new window.
bind-key 'C' new-window -c "#{pane_current_path}" # Create a new window on CWD.

bind-key 'w' command-prompt -T window-target -p 'Switch to window index:' { select-window -t ":%%" } # Prompt for window index to select.
bind-key 'W' choose-tree -Zw                     # Choose a window from a list.
bind-key 'a' last-window                         # Select the previously current window.
bind-key 'i' command-prompt "rename-window '%%'" # Rename window.

bind-key 'X' confirm-before -p "kill-window #W? (y/n)" kill-window # Prompt to kill currently active window.

bind-key -n 'M-[' previous-window      # Switch to window on the left.
bind-key -n 'M-]' next-window          # Switch to window on the right.
bind-key -n 'M-{' swap-window -d -t -1 # Move active window to the left.
bind-key -n 'M-}' swap-window -d -t +1 # Move active window to the right.

bind-key 'j' choose-window 'join-pane -h -s "%%"'\; display 'Choose a pane you want to horizontally join to this window' # Horizontally join panes to currently active window.
bind-key 'J' choose-window 'join-pane -s "%%"'   \; display 'Choose a pane you want to vertically join to this window'   # Vertically join panes to currently active window.
#: }}}
#: Session & client management {{{
bind-key 'I' command-prompt "rename-session '%%'" # Rename session.
bind-key 'C-c' new-session # Create new session.
bind-key 'C-x' confirm-before -p "kill-session #S? (y/n)" kill-session # Kill session.
#: }}}
